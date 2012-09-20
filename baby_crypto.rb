class BabyCrypto

  def decrypt(key, value)
    ((key.class == Fixnum) || (key.to_i != 0)) ? offset = key.to_s.split.map {|i| i.to_i} : offset = calc_offset(key)
    decrypted, off_i = [], 1
    value.split('').each_with_index do |val, i|
      val.ord >= 97 && val.ord <= 122 ? dist = val.ord + (offset[off_i -1] % 26) : dist = val.ord
      dist > 122 && dist!= val.ord ? (decrypted.push (122 - (26 - (dist - 122))).chr) : (decrypted.push dist.chr)
      off_i % (offset.length) == 0 ? off_i = 1 : off_i = off_i + 1
    end
    return decrypted.join
  end

  def encrypt(key, value)
    ((key.class == Fixnum) || (key.to_i != 0)) ? offset = key.to_s.split.map {|i| i.to_i} : offset = calc_offset(key)
    encrypted, off_i = [], 1
    value.split('').each_with_index do |val, i|
      val.ord >= 97 && val.ord <= 122 ? dist = val.ord - (offset[off_i -1] % 26) : dist = val.ord
      dist < 97 && dist != val.ord ? (encrypted.push (122 - (97 - (dist+1))).chr) : (encrypted.push dist.chr)
      off_i % (ocffset.length) == 0 ? off_i = 1 : off_i = off_i + 1
    end
    return encrypted.join
  end
  
  def encrypt_single_key(key,value)
    offset,encrypted, off_i = key,[] , 1
    value.split('').each_with_index do |val, i|
      val.ord >= 97 && val.ord <= 122 ? dist = val.ord - (offset % 26) : dist = val.ord
      dist < 97 && dist != val.ord ? (encrypted.push (122 - (97 - (dist+1))).chr) : (encrypted.push dist.chr)
    end
    return encrypted.join
  end

  def decrypt_single_key(key,value)
    offset,decrypted, off_i = key,[] , 1
    value.split('').each_with_index do |val, i|
      val.ord >= 97 && val.ord <= 122 ? dist = (val.ord + offset % 26) : dist = val.ord
      dist > 122 && dist!= val.ord ? (decrypted.push (122 - (26 - (dist - 122))).chr) : (decrypted.push dist.chr)
    end
    return decrypted.join
  end

  def calc_offset(key)    
    offset, key_1, key_2 = [], key.split[0].split(''), key.split[1].split('')
    key_1.each_with_index do |val,i|
      dist = key_2[i].ord - val.ord
      dist >=  0 ? offset[i] = dist : offset[i] = dist + 26
    end
    return offset
  end

  def freq_anal(msg)
    freq,msg_arr,sum = Hash.new(0),msg.split(''),0
    msg_arr.each_with_index {|i,j| msg_arr.delete_at(j) if i == " "}.each {|i| freq[i],sum = freq[i] + 1,sum +1}
    return freq.each {|a,b| freq[a] = calc_perc(b,sum)}.sort_by {|i,j| j}.reverse
  end

  def freq_anal_first(msg)
    f_freq,msg_arr,sum = Hash.new(0),msg.split(' '),0
    msg_arr.each {|i| i.split('').each_with_index do |a,b| 
      f_freq[a], sum = f_freq[a] + 1, sum +1 if b == 0
    end}
    return f_freq.each {|a,b| f_freq[a] = calc_perc(b,sum)}.sort_by {|i,j| j}.reverse
  end

  def calc_perc(val,total)
    return ((val.to_f / total.to_f) * 100).round(3)
  end

end
