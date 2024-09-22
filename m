Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F433C8;
	Sun, 22 Sep 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727014439; cv=none; b=h43mg32960YMr3A4pR3/m+Ytllij+T0Vqfc1CgEkh0JdHIn/vcWyUznbW/spadmma1tvRSLIye8KYYXJBt5cLqmkIqVT3X7Qaah8l6AnwBL7x11+H6pn/Rr8SZGJLETRdRxmVxUHgncyt3T0rt8Mb6vf61EpK8VxpmNkjJp8//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727014439; c=relaxed/simple;
	bh=3fAe8Gix3+hT1ekAMKfp7MFwOapu/svSucP1/6IWdZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2JzbEgCpBxIcRBJkF4QTLAro+scI21/6QTkqDRvZNVINowiDKFFpVb2btjCb2DhHXLmErsRaGWN+9tRTj/yjbqvBi8LUtueY+VukkgCxBLiI5if2Wi34K06bZOkOdTlLezMZPotQKSk+49MAOizA0FfX0oXKhKTYbP1XT2wTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0ahQkG6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0ahQkG6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-206aee40676so28733175ad.0;
        Sun, 22 Sep 2024 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727014437; x=1727619237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H60osoPEQIRFYd/ZJmgRWiIyxJNfdxxhbTW+sQ2BYKg=;
        b=a0ahQkG6W1OQUOg4xjTqHt9Km0ssFykGd2Duo8jDsMWK3wov0H8MNEi8o5UtFIBZQA
         ie6Ml1v4/J0h96jGAWf3W9rd6VfY1FmaJQPHmx818XEDQwLPSpQAhLdYxwtber3iLMSb
         4WgWOGGTeDLgtiZTv392OlidT0Wb+WN4WITqOUTE/t/ZYclS/US8khMV1Sk+Axqvgkss
         /MWAlr2XmLEhiPxTtaMCaFrCv2Ps3uFL5kFNfX6HgPZCymY166mHOC5HWaxlt6g+/jFw
         Skx4XBKIOaHBq4Qeplbr8zMUAqRh8tukhHDI3KFgarvvkIPFB07AbeLWMvTczQWuGQ+B
         h/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727014437; x=1727619237;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H60osoPEQIRFYd/ZJmgRWiIyxJNfdxxhbTW+sQ2BYKg=;
        b=WcAnvwxMP/4Z/f6z+DOhCEznjwM8IyXOI7Ki4cTjvNNq0UFxoaiN4sxGB2EXhdL/5w
         fEj5iwzDhigY51aBA5VWe1cob2O/xk5PyZQPWoaIGNuS+7SyUjqI5TtShLi3bqbprG5m
         8/X36UQtnEE9AfCtqKJDpgNkxOaLikwIRXrzb/9kh0fUPEOBqa+mWModP7PEDK2wt8tb
         JYhQNOBu7LBWZYBRENcfrvnWuAdgmHf2EhQs4cvzOCIxxR6G3KpJi9t1W5XKgi0NyZEz
         WheW6AJAPsJ0lUUG23/1jXGtnkAFNE89BYlndlfF2Sojp7/S3yxC11nvZabtjhFw7y8y
         ehMg==
X-Forwarded-Encrypted: i=1; AJvYcCWDnSFsis9q5pZDaUoESXUGhIQFCmyLoiHEe/IGaHhzsyAJ1kPVtdevOWk3yJf9tQdEdIcH@vger.kernel.org, AJvYcCXdXdvPnDXi4DpbqHLeVlfNmTodWGVuIfipqd0Xlptsz+H1cbg0aXxa4fzQ7GYBme7Nd0zbEy19zP07F5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrlYzTF7CG+nml/l88nUDms2nadwWvRPybW3i7jRQwANS3YU0
	y9s6+V9UZUnMRaOg6NHrx+5U1mJ03MIugnXx6Ha5c3VZS808c8Yg
X-Google-Smtp-Source: AGHT+IEHaxKkIqBBTPuNrLXpgy1OHoUd7mAxeSwx64GY4yclAXmUc8XcyqlQKUnXJbVWazIj77emvw==
X-Received: by 2002:a17:902:d546:b0:206:8f25:a3e with SMTP id d9443c01a7336-208d841ff88mr130901425ad.53.1727014436696;
        Sun, 22 Sep 2024 07:13:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473083fsm120417355ad.258.2024.09.22.07.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 07:13:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fcaaf6b9-f284-4983-a8e3-e282dd95fc16@roeck-us.net>
Date: Sun, 22 Sep 2024 07:13:53 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] kunit, slub: add test_kfree_rcu() and
 test_leak_destroy()
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: KUnit Development <kunit-dev@googlegroups.com>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, "Paul E. McKenney" <paulmck@kernel.org>,
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
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-7-ea79102f428c@suse.cz>
 <6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net>
 <07d5a214-a6c2-4444-8122-0a7b1cdd711f@suse.cz>
 <73f9e6d7-f5c0-4cdc-a9c4-dde3e2fb057c@roeck-us.net>
 <474b0519-b354-4370-84ac-411fd3d6d14b@suse.cz>
 <CAB=+i9SQHqVrfUbuSgsKbD07k37MUsPcU7NMSYgwXhLL+UhF2w@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAB=+i9SQHqVrfUbuSgsKbD07k37MUsPcU7NMSYgwXhLL+UhF2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/24 23:16, Hyeonggon Yoo wrote:
> On Sun, Sep 22, 2024 at 6:25 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 9/21/24 23:08, Guenter Roeck wrote:
>>> On 9/21/24 13:40, Vlastimil Babka wrote:
>>>> +CC kunit folks
>>>>
>>>> On 9/20/24 15:35, Guenter Roeck wrote:
>>>>> Hi,
>>>>
>>>> Hi,
>>>>
>>>>> On Wed, Aug 07, 2024 at 12:31:20PM +0200, Vlastimil Babka wrote:
>>>>>> Add a test that will create cache, allocate one object, kfree_rcu() it
>>>>>> and attempt to destroy it. As long as the usage of kvfree_rcu_barrier()
>>>>>> in kmem_cache_destroy() works correctly, there should be no warnings in
>>>>>> dmesg and the test should pass.
>>>>>>
>>>>>> Additionally add a test_leak_destroy() test that leaks an object on
>>>>>> purpose and verifies that kmem_cache_destroy() catches it.
>>>>>>
>>>>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>>>>
>>>>> This test case, when run, triggers a warning traceback.
>>>>>
>>>>> kmem_cache_destroy TestSlub_kfree_rcu: Slab cache still has objects when called from test_leak_destroy+0x70/0x11c
>>>>> WARNING: CPU: 0 PID: 715 at mm/slab_common.c:511 kmem_cache_destroy+0x1dc/0x1e4
>>>>
>>>> Yes that should be suppressed like the other slub_kunit tests do. I have
>>>> assumed it's not that urgent because for example the KASAN kunit tests all
>>>> produce tons of warnings and thus assumed it's in some way acceptable for
>>>> kunit tests to do.
>>>>
>>>
>>> I have all tests which generate warning backtraces disabled. Trying to identify
>>> which warnings are noise and which warnings are on purpose doesn't scale,
>>> so it is all or nothing for me. I tried earlier to introduce a patch series
>>> which would enable selective backtrace suppression, but that died the death
>>> of architecture maintainers not caring and people demanding it to be perfect
>>> (meaning it only addressed WARNING: backtraces and not BUG: backtraces,
>>> and apparently that wasn't good enough).
>>
>> Ah, didn't know, too bad.
>>
>>> If the backtrace is intentional (and I think you are saying that it is),
>>> I'll simply disable the test. That may be a bit counter-productive, but
>>> there is really no alternative for me.
>>
>> It's intentional in the sense that the test intentionally triggers a
>> condition that normally produces a warning. Many if the slub kunit test do
>> that, but are able to suppress printing the warning when it happens in the
>> kunit context. I forgot to do that for the new test initially as the warning
>> there happens from a different path that those that already have the kunit
>> suppression, but we'll implement that suppression there too ASAP.
> 
> We might also need to address the concern of the commit
> 7302e91f39a ("mm/slab_common: use WARN() if cache still has objects on
> destroy"),
> the concern that some users prefer WARN() over pr_err() to catch
> errors on testing systems
> which relies on WARN() format, and to respect panic_on_warn.
> 
> So we might need to call WARN() instead of pr_err() if there are errors in
> slub error handling code in general, except when running kunit tests?
> 

If people _want_ to see WARNING backtraces generated on purpose, so be it.
For me it means that _real_ WARNING backtraces disappear in the noise.
Manually maintaining a list of expected warning backtraces is too maintenance
expensive for me, so I simply disable all kunit tests which generate
backtraces on purpose. That is just me, though. Other testbeds may have
more resources available and may be perfectly happy with the associated
maintenance cost.

In this specific case, I now have disabled slub kunit tests, and, as
mentioned before, from my perspective there is no need to change the
code just to accommodate my needs. I'll do the same with all other new
unit tests which generate backtraces in the future, without bothering
anyone.

Sorry for the noise.

Thanks,
Guenter

