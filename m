Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA332F75B;
	Wed, 26 Aug 2026 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787728391; cv=none; b=Y2h2IB8zkS6T5V8JwxcyUs71kNj449MNy44TKM4MeZTfmifSzT9FjeS3WmPfe8e162lxN49j2OcUFDoHxM/i1fgv4J/mSMhrDAvKJz3Sciv6xcyqBGXBZKDtb/9NmkUmBhReFWCQ/FrRP4FCkynNLZpRgBR0jfEqZLCDz/w/nYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787728391; c=relaxed/simple;
	bh=g6KhwdgBgR34sHp0uR2HRGrPx8bQcNfOIEsEuvTj878=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvV+jzpbwTiF5yTF1LwH1o//yL1nODhZOhgncr7moTxrzMkl+akt0nD6N5xUd4V5bihA6EdZIcWfzJIL+KlbzEhAD7RnkGi6aEjbeX6O0hjIcZDNdZD6GELrUL6wr4OHE37OMuJabymkxYpYIWZxIyB2mHH0cvtR+O1o9AIb04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OwOvhmtz; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OwOvhmtz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=YMj/68VBwbCteYKyTb/CDtKHGIohm/Yd4Nbofe6Ek1M=;
	b=OwOvhmtzYLIzANJoLSpF536BKIWkOpx6ClJmpmafH+0+s+WE84MvEOm+sJaygN
	6z8YR9j5WujJfoOrZrrKzM/1cL8enAUxu8g+zf90dYfYHJoN2KfoJiZ/1hJnIZ8a
	Cq0saWHd2VOb0a4lEl3AyDRd3Ip1elMsOHHzVXg9Z2yks=
Received: from [IPV6:2409:8d1e:e12:7fe:b7cb:e263:e9d9:f20f] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnl0jSkY5qucu3SA--.999S2;
	Wed, 26 Aug 2026 15:12:20 +0800 (CST)
Message-ID: <e5afbca9-77f0-4727-a825-440df45c89ca@163.com>
Date: Wed, 26 Aug 2026 15:12:18 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/slab_common: fix shrink budget underflow in
 kfree_rcu_shrink_scan
To: Hao Li <hao.li@linux.dev>
Cc: vbabka@kernel.org, harry@kernel.org, akpm@linux-foundation.org,
 cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
 rcu@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>
References: <20260824091838.1692153-1-xialonglong2025@163.com>
 <ao5UqBL4iPh8zlpG@fedora>
From: Longlong Xia <xialonglong2025@163.com>
In-Reply-To: <ao5UqBL4iPh8zlpG@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnl0jSkY5qucu3SA--.999S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww43ZryxArWfWw4xXw47urg_yoW8Aw1DpF
	Wqka4Utr40qr429rn7Za18JryYq3ySkFWxGF9Y9FW3J3s09wn3tay7tr1q9rWYkr1kXa1F
	9rnF93WUZa4qyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5nYwUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC3BTX0GqOkdS5VgAA3B


在 2026/8/26 10:56, Hao Li 写道:
> On Mon, Aug 24, 2026 at 05:18:38PM +0800, Longlong Xia wrote:
>> From: Longlong Xia <xialonglong@kylinos.cn>
>>
>> The kfree_rcu shrinker decremented sc->nr_to_scan (unsigned long)
>> and then tested the result with <= 0. When a single CPU's object
>> count exceeds the remaining budget, the subtraction wraps to a large
>> positive value and the <= 0 comparison, which is equivalent to == 0
>> for an unsigned type, never fires again. The scan loop then iterates
>> through every possible CPU instead of honouring the reclaim budget.
>>
>> Reorder the logic to compare count against nr_to_scan before
>> subtracting, so the loop exits as soon as the budget is met.
>>
>> Assisted-by: Codex:gpt-5.6-sol
>> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
>> ---
>>   mm/slab_common.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 657fd75776ea..95ddbab290d4 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -2172,11 +2172,11 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>>   		count += drain_page_cache(krcp);
>>   		kfree_rcu_monitor(&krcp->monitor_work.work);
>>   
>> -		sc->nr_to_scan -= count;
>>   		freed += count;
>>   
>> -		if (sc->nr_to_scan <= 0)
>> +		if (count >= sc->nr_to_scan)
>>   			break;
>> +		sc->nr_to_scan -= count;
> thanks, this is indeed a problem.
> I think we could make the code more better, for example:
>
> 1. remove `count` variable
> 2. add count to freed directly (also change type to unsigned)
> 3. check `if (freed >= sc->nr_to_scan)` then break.
>
> How does this sound to you?
Thanks for the reply.

Sounds good -- I'll adopt it for v2.

v2 incoming, with Suggested-by from you.


Thanks，

Longlong

