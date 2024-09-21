Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39F13D25E;
	Sat, 21 Sep 2024 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726952887; cv=none; b=K8aEKQ/hbGYO3mB3YJXGciO4UZCe7Xzu3wW51Y/49lLhSUMLoxPd6+5/uchfn1JI6ziYjZyMiMbJgTSWdOT6nsv4L3Ao+8r1pOF9Xp/4WXKDCjCJtly9FCeaTq7xACY/kDjZ3ZT0tFXMj7eofBnjsPRJ1vopRbAGKM/ZgrXpBHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726952887; c=relaxed/simple;
	bh=khZwdcOBs5gGfhJEK4YQG6FqyCHy25/oDbHmVHP2f+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwSCB7O2NPqNO1dSR+N+gwpG8Yqdes9dQe99RrwTUPMwMByO0KbGQJW0vBXtcIfaTAXDbAtw5Ul06A8CQLUT66Sc5uDgQEzF1s/WVd+1/hzcl357fkTofGOvwMmuMVadsy9k2dQHlgTePCqq//SS3oxvSd6o00m4Vz9KImvNPOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yfrtt79d; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfrtt79d"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7db12af2f31so2692243a12.1;
        Sat, 21 Sep 2024 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726952885; x=1727557685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZyEP8RqiEX4aO8buEZUbFkfwoj9qwj5TS4bmseu6C8=;
        b=Yfrtt79dZnIMm19r63uM/ssYSUs7jSw4i60LWTswNCyGD+EdRL3IofaxbZqm9wbpZJ
         faSLxcXa6VT+kKEd9eX661RCh7Mfu/20BmHmCbiChJGMsIXbTM3jgMWR8E3JYEK6WQy+
         TPh0U21J01rFowiMeMmy3RkCxVmOl8FwN/XIZl96oBVmKOkEhaFYQW0robDf3p2bgHN6
         ICOeYvaKxi6TLnhOkfG8EWr5pZpc1NRyg2GUmbJqzNXaNG6VmsHrzqmr1CcbNffuUhAN
         d1c+c/IdNPaX09ySlUpdcqUR+qyb00uDfS3ZeJo5ZdHBUg+UGE13UvH8U0XqoybCH9wz
         2m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726952885; x=1727557685;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZyEP8RqiEX4aO8buEZUbFkfwoj9qwj5TS4bmseu6C8=;
        b=ezPVmLUYefTvtoA5KmUwKd0z80BtpRHsZJAWZQOfPY+TpKllK8K4dwBBwJO7Kiy85h
         +czEy0fW8VT7+7h6Xbk6ymtkDdYv1wQ0JYBHeGWsp43bk+LKIqs5xmOfNgaYvXDSihv1
         BjdP2HOln4WocMHIoltY91oN6sLD+t7apx4nOHLLg7qWqESRWhrr9WgmbWuju85C36qu
         nbucgy9uRgZfz5H24ycOXvqr+eXWAR9xg79iVFK4U2EU4F/+6lR2xuaA5UWciaH4smVY
         ECz2aafGHaKHwlj3a6DbHCqfsPDNAunZb0X1BGoIreyNgtDsqY+aWRbUN9wsoKp2DYXP
         lgXA==
X-Forwarded-Encrypted: i=1; AJvYcCVrAv+heLgkhaXBIaf3+NA2109M+lH4CVIr+6O70awPOuPjRyRJ+8clGXwDXbC0e+w6auXO@vger.kernel.org, AJvYcCXqitEicaUwJD65iQpk6jVEW01EwvnqrpDOphdMxJyWurRKxx7eOF6mRzXU94UmiEMqTr2azT15B/ChdTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBJEPThZyxX5BNuHXwuMCAQlLsn9OJvXkHOXOvCCQeegvUWFdX
	G0orNzh4JHG0d6Nocz3oSWwIFsHnVRlmSxA2zq4g1DKWJN+Z04EF
X-Google-Smtp-Source: AGHT+IFsRje/0urX0VCD2ctAQ/mPIn2BatWB9vkwQboQK13ENiIwcBVwwzcPWMMiHGBy1DHazHIZFw==
X-Received: by 2002:a05:6a20:2d0b:b0:1cf:6533:5c82 with SMTP id adf61e73a8af0-1d30a94b2f5mr12037658637.26.1726952884555;
        Sat, 21 Sep 2024 14:08:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7cfa1sm11657785b3a.104.2024.09.21.14.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 14:08:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <73f9e6d7-f5c0-4cdc-a9c4-dde3e2fb057c@roeck-us.net>
Date: Sat, 21 Sep 2024 14:08:00 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] kunit, slub: add test_kfree_rcu() and
 test_leak_destroy()
To: Vlastimil Babka <vbabka@suse.cz>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-7-ea79102f428c@suse.cz>
 <6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net>
 <07d5a214-a6c2-4444-8122-0a7b1cdd711f@suse.cz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <07d5a214-a6c2-4444-8122-0a7b1cdd711f@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/24 13:40, Vlastimil Babka wrote:
> +CC kunit folks
> 
> On 9/20/24 15:35, Guenter Roeck wrote:
>> Hi,
> 
> Hi,
> 
>> On Wed, Aug 07, 2024 at 12:31:20PM +0200, Vlastimil Babka wrote:
>>> Add a test that will create cache, allocate one object, kfree_rcu() it
>>> and attempt to destroy it. As long as the usage of kvfree_rcu_barrier()
>>> in kmem_cache_destroy() works correctly, there should be no warnings in
>>> dmesg and the test should pass.
>>>
>>> Additionally add a test_leak_destroy() test that leaks an object on
>>> purpose and verifies that kmem_cache_destroy() catches it.
>>>
>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>
>> This test case, when run, triggers a warning traceback.
>>
>> kmem_cache_destroy TestSlub_kfree_rcu: Slab cache still has objects when called from test_leak_destroy+0x70/0x11c
>> WARNING: CPU: 0 PID: 715 at mm/slab_common.c:511 kmem_cache_destroy+0x1dc/0x1e4
> 
> Yes that should be suppressed like the other slub_kunit tests do. I have
> assumed it's not that urgent because for example the KASAN kunit tests all
> produce tons of warnings and thus assumed it's in some way acceptable for
> kunit tests to do.
> 

I have all tests which generate warning backtraces disabled. Trying to identify
which warnings are noise and which warnings are on purpose doesn't scale,
so it is all or nothing for me. I tried earlier to introduce a patch series
which would enable selective backtrace suppression, but that died the death
of architecture maintainers not caring and people demanding it to be perfect
(meaning it only addressed WARNING: backtraces and not BUG: backtraces,
and apparently that wasn't good enough).

If the backtrace is intentional (and I think you are saying that it is),
I'll simply disable the test. That may be a bit counter-productive, but
there is really no alternative for me.

>> That is, however, not the worst of it. It also causes boot stalls on
>> several platforms and architectures (various arm platforms, arm64,
>> loongarch, various ppc, and various x86_64). Reverting it fixes the
>> problem. Bisect results are attached for reference.
> 
> OK, this part is unexpected. I assume you have the test built-in and not a
> module, otherwise it can't affect boot? And by stall you mean a delay or a

Yes.

> complete lockup? I've tried to reproduce that with virtme, but it seemed
> fine, maybe it's .config specific?

It is a complete lockup.

> 
> I do wonder about the placement of the call of kunit_run_all_tests() from
> kernel_init_freeable() as that's before a bunch of initialization finishes.
> 
> For example, system_state = SYSTEM_RUNNING; and rcu_end_inkernel_boot() only
> happens later in kernel_init(). I wouldn't be surprised if that means
> calling kfree_rcu() or rcu_barrier() or kvfree_rcu_barrier() as part of the
> slub tests is too early.
> 
> Does the diff below fix the problem? Any advice from kunit folks? I could
> perhaps possibly make the slab test module-only instead of tristate or do
> some ifdef builtin on the problematic tests, but maybe it wouldn't be
> necessary with kunit_run_all_tests() happening a bit later.
> 

It does, at least based on my limited testing. However, given that the
backtrace is apparently intentional, it doesn't really matter - I'll disable
the test instead.

Thanks,
Guenter

