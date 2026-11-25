Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612476;
	b=pm0uN08NMd6n1dZErbhliEB+ZFT8OqmxmguZ9nobu08sFrSKiRbeW+CKA3beGFjBZfPs
	 UtEexAlAyWPB272cFnAlEDGCMe/9Oz5+TQounVcfxq36/2m4gO/qzmEMjBrfBalZtpswO
	 a2J/m2WXAnJB+aJfJMBfO0lJ0Vj7xlhTx0w/r21crrtsyUrbW0qIP7TgBdBjjCz9ykBxT
	 /XkFck7ntSfSw1Tqb+DW08CGNAKoF/mUwqVpgr/nuMxkiRyuDaR+HHJ7XfsihJQfOrT3R
	 2Usmfd132fQR0qqup5ebL6PLiFX819ILjckG2vZfByiQxOA7rZCixCuHSP6dJc7HQsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612476;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0nMz/PU6p6rxstnwsd4g3DPOFgXmUrtZFmxHK6dNxgY=;
	b=XW2+tHN8aH9mZRDnnRMghhdlQiP0AE7o2H6MGRZDfh/MU2nLzIh3nU5ChlvcRK2OrA1r
	 lzMlOEtvAAd26MVBtkpmOOsEOVACNplyFm5yFg62QKIN/PqcoNSzfiG+K+mI0UpkzgYyU
	 o5HVdNU4HF6l2mW/XI2wkThEC+nglPAEMqjnVPgpoD95uhO0ObiKe/A0TEAau3M0pg4JG
	 uQnlvsqU3RgM/hSXYniqHGj35BRj9UJnYj8jurn5uemDWPqR8xH4iInBW6zYcHWAuZSOU
	 7pim8LL79tNWt6Tc/Em/arX6jnU3X6sMU/Jfo5aml6M2z872bUGxuaObeFwdtiNBcKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xqX0RlJB;
	arc=none smtp.remote-ip=91.218.175.165
Received: from mta0.migadu.com (out-165.mta0.migadu.com [91.218.175.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA2606A321
	for <rcu@vger.kernel.org>; Wed, 25 Nov 2026 13:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76DA2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xqX0RlJB
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+3skVRQZws6mNDzAhaeG8SDVhHgNE+CK66G995MnGIs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795612473; v=1; x=1796217273;
 b=xqX0RlJBnTer6Ss4NYAHzHHbl+FJllRia84UCOmPQZJ0/3YL2OCRDj1jBXwDM5yFUDV1VNcY
 NAKLkdpaFVxC+DFvRh6BIppIEQsHQcuAlk370oH2GZ4OainXVDkSXgBVgeP89HUldrjW6nqGFpc
 zvlQJ+rh9aBcMSpXlXcw4YC0=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4b3a9389f4f16c39;
	Wed, 25 Nov 2026 13:14:33 +0000
X-Mizu-Trace-ID: 4b3a9389f4f16c39
X-Migadu-Flow: FLOW_OUT
Message-ID: <66189c93-6f82-4ac7-9538-2a036842f70e@linux.dev>
Date: Wed, 25 Nov 2026 21:14:22 +0800
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] docs/zh_CN: Add RCU/whatisRCU.rst Chinese
 translation
To: Weijie Yuan <wy@wyuan.org>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, alexs@kernel.org, si.yanteng@linux.dev,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 paulmck@kernel.org, linux-doc@vger.kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118131636.5131-1-xiongwei.song@linux.dev>
 <20261118131636.5131-3-xiongwei.song@linux.dev>
 <09ef3d3d-0e68-49c6-a6a2-c754104ede9e@hust.edu.cn>
 <946792d2-4241-445d-820b-301a570ee2c3@linux.dev> <awZZVV3BlovD-xNf@wyuan.org>
From: Bruce Song <xiongwei.song@linux.dev>
In-Reply-To: <awZZVV3BlovD-xNf@wyuan.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/25/2026 11:43 AM, Weijie Yuan wrote:
> On Tue, Nov 24, 2026 at 10:23:50PM +0800, Bruce Song wrote:
> 
> [...]
> 
>>>> +:翻译:
>>>> +
>>>> + 宋雄微 Xiongwei Song <xiongwei.song@linux.dev>
>>>> +
>>>> +:校译:
>>>> +
>>>> +.. _zh_cn_whatisrcu_doc:
>>>
>>>
>>> Please double check all the references. If one reference is not referred
>>> from other places, please remove it in the translation.
>>
>> Ok, I will do that.
> 
> Let's make it a rule or instruction, shall we?
> 
> I didn't find any specific rules for label usage in doc-guide dir. (only
> no more top-level label on list) But I suspect there must be unused
> labels in English docs.
> 
> We either:
> 
> (1) make it consistent, i.e. keep adding unused labels.

I feel like this one is better. Maybe the unsued labels will be used in 
the future?

> 
> or
> 
> (2) check usused labels and do not create new labels for it.
> 
> 1 may be easier for manual translating jobs that you don't need to check
> every label manually. You just need to add a '_zh' before each original
> label. But apparently this will create tons of unused labels. So, no?
> 
> 2 may costs more attention, but I guess agents could handle this
> nowadays with proper prompts.
> 
> I forgot to mention this thing in Daniel's series [*], shall we mention
> this now, or send a RFC patch after they get merged?
> 
> And also, add a rule for English docs that _do_not_ write a label which
> is not used? This will make our job easier.
> 
> [*] https://lore.kernel.org/linux-doc/20261119041009.63651-1-danielmaraboo@gmail.com/
> 
> 
> [...]
> 
> 
>>>> +概括起来如下：
>>>> +
>>>> +-    使用rcu_read_lock()和rcu_read_unlock()守护RCU读端临界区。
>>>> +
>>>> +-    在一个RCU读端临界区之内, 使用rcu_dereference()解引用RCU保护的指针。
>>>> +
>>>> +-    使用可靠的设计（例如锁或信号量）保持在互相干扰的情况下并发更新。
>>>
>>>
>>> |The original says to use locks or semaphores to prevent concurrent
>>> updates from interfering with each other. Please change this to “使用可
>>> 靠的设计（例如锁或信号量）防止并发更新互相干扰”。|
>>
>> The verb in original doc is "keep", and the objective is "updates" here.
>> IMO, "prevent" has changed the original meaning, and the objective has been
>> changed to "interfering with each other". Or do you have any other thoughts?
> 
> In my dictionary, "keep A from doing B" means "防止 A 做 B",
> so something like:
> 
> Use some solid design (such as locks or semaphores) to keep
> concurrent updates from interfering with each other.
> 
> 采用可靠的同步机制（例如锁或信号量），防止并发更新相互干扰。

I tried the google translator, and the translation looks similar with 
the above one. But one thing I'd like to mention is maybe "采用可靠的设计" is 
more accurate than "采用可靠的同步机制"？

To be honest, I used the google translator sometimes when I translated 
this article. However, I don't think the results are good as we 
expected, so I never trust it 100%.

Regards,
Xiongwei
