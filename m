Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA52D94AB;
	Tue, 19 May 2026 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779166335; cv=none; b=bUbE5BTianWB21Q6EV2xIVz2BCmGpxOaYY+GIzjU8OSFzJtQdwIh5lj+4krh+DWFvzydrk78q6PuiYBq8NWlAINWOt6oC5yXP7D2MNZ1wELAnmpMz+1t4icUv4YipNi5i5JKI5ABG4ISlNJ85vNvlb7dFvdmdqWQSxiKXpabQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779166335; c=relaxed/simple;
	bh=/HR6KNEhm9RlYnNQYcHck5sV+fdadssIRhSj5BGOslU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRBp08+2P3z8kK+RoZOX0UF2z10SlahN7XnlQXvHAobek0TBcqNLVbQCatAOoA+LXtObpH7BwZddtgoplQ0237Q5DzbFWSiDO0L8tS+ElBtCPvs2y37AlB1yB9Ekugf0O6pcHRh6DI8jumLQgpwhKu40QTiYk0uN2Lzm+2wRZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hcx2v/Ao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hcx2v/Ao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0784C2BCB3;
	Tue, 19 May 2026 04:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779166335;
	bh=/HR6KNEhm9RlYnNQYcHck5sV+fdadssIRhSj5BGOslU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hcx2v/AoPAMs0cKkZdKF99AKEA1QEcEFDp6mG378/M9dODP70cf/ook1n3HgjDoBo
	 rjP91awXQR2fdFacO6sz/YcgfqvQCqC3UoP6UHyORTUdyNc6Z0PxFb/Ucf8Inwo5Y+
	 H1Z/SllivuhdvOruZQgQhXTPQ2TYKma2pPqx/YW2ZVE0IE0TrvSHwkJTTfVo5Xcv8N
	 jzzJPf0Kozg+bQAgR0K4Dq1yUTUJpJ0kvpsMXjN6aEipSiIXKo2hORDmGXhlt4Fjq2
	 uh6lTSaiQiO1m6/4ZU0t2quswoMVkN59yxQPBT8AUvc9I5QC+CThwtKqUY6JKmD+zK
	 k6jR/i7t5hfZw==
Message-ID: <dc492675-2323-4acb-a6e7-da75a0c2f208@kernel.org>
Date: Tue, 19 May 2026 06:52:07 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v1 05/12] srcu: Don't queue workqueue handlers to
 never-online CPUs
To: Boqun Feng <boqun@kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Frederic Weisbecker
 <frederic@kernel.org>, Samir <samir@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260511175448.153326-1-urezki@gmail.com>
 <20260511175448.153326-6-urezki@gmail.com>
 <f669fbc9-c068-489f-bd91-4e81561a6e58@leemhuis.info> <agm4-6f-6rOgQPFB@pc636>
 <3dd5cce0-51f9-4cf1-81b8-246e6c6a633a@paulmck-laptop>
 <53d546e4-8db0-4e14-a79d-270212081be7@leemhuis.info>
 <ags6ug97zNR6Fiiw@tardis.local>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <ags6ug97zNR6Fiiw@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 05. 26, 18:13, Boqun Feng wrote:
>>>> I assume it will be picked to stable
>>
>> Thx for the reply. This answered the second aspect I raised. What about
>> the first: shouldn't this be heading to mainline this cycle, ideally
>> quite soon? Or is this the plan and I misinterpreted the "-next" in the
>> subject?
>>
>> Sadly Jiri (now CCed) afaics didn't yet report if this fix helped to fix
>> the issues they were seeing, but it sounded a lot like it was likely:
>> https://lore.kernel.org/all/f0351414-41af-4f74-899c-87fb5bb45621@kernel.org/

Yes, it did!

You could have checked the linked bug, BTW:
https://bugzilla.suse.com/show_bug.cgi?id=1263947#c19

 > works nicely without complaining about non-existant CPUs

and:

 > seems stopped messages about workqueue lockup and not exist CPUs at 
kernel 7.0.7-1-default now

But:
 > FYI the power8 machine hangs using 7.0.7-2.gf1d450c-default, to be 
investigated.

That's likely not related.

thanks,
-- 
js
suse labs
