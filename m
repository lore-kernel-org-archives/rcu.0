Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055331DE4E1
	for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766187925; cv=none; b=Yg5JLUF6tKRy8gepCgj8qSdAtm61qCqqNW++ZtwnLRsnTkUBg1fNh+mn7cdmPTUKenUgjW9/AfVCKUBHa6V2bs5YNJ1ejxm621X+yXI0kMrqEZ7Ap5ANEW2ASBNU1fC3yfxmIdzTUsNjYLJ2ey4oVB0N0PWoFzfM50AXNDInK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766187925; c=relaxed/simple;
	bh=kqYAQZ609rJygFWC7CbHOEHNatKsPADzGjHUdHPU3XE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X5aB3ltfGWadiaqCSbHYIx+t38/VVidwBITMySLM6P0BFiYx/5rFfvCDB3Y3yxra17rzHXbapdZBrZnJlcLkro06p41/D2L+KkNMxgjVJ/yL6sc+5CIIAgZXMaMEh3nm87V5Z/fBnvJ9n/mavI9pd60xlm3eWS0FYGAH0iDsyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9WGTrqs; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9WGTrqs"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34c902f6845so2985663a91.2
        for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 15:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766187923; x=1766792723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xjhz9NvSIj1nkwStS3EsBbpnWvjG3hzX9yFNjSmaNpQ=;
        b=X9WGTrqsKx+yBbtBgx3qv7Dvb/oN85bUanv54a8kZoZ2F4PLC6FoJLg9CbqNGVGN8I
         Q8K0b8ywR9q89dWAwq/OsNJUjdixu9h0w+GiYhok4WxFse46Kx+W+Tmdjd8V2H8z5Rr4
         n5dqxoaJ0yQbtUzbUlD2gR9Yj8SSC8WF9+alnTKsc4Rr+OcFJgvmCFq/ITVUaJ/B2eGE
         o69fJQvYJGcC7ElIjK0cRI4XHqU8jo60IjSIUvTaMs7ndFh7Pbr4imwtXk6Z/xXjFC0Z
         IXKpFF5ysWmwCyg+o37mVrZ4LzXcDNDcixY+Fyx/HpthUHJG0Xt+8dZLsmFW1lkt7B9v
         LgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766187923; x=1766792723;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjhz9NvSIj1nkwStS3EsBbpnWvjG3hzX9yFNjSmaNpQ=;
        b=BKZaHVYISkujFVwyrUstq2C8BgzkZQA+8tc4uGe5j2aozgG2UR1hrZEHskQ+PMq/SK
         Hd9wmKHWtISWlK8eh4upa5zghpT/c7c5QYTm794V0WpZXFLhfIwJdcChmS8a0gdpfREM
         PEHT5DP+FcmjLmnpkYyGHK0BCHKJJ1p1aDDOPkyHlRFEN3WTjPNX0O7JIepLpF5xSpL8
         Mlgh+GJoqgfqNZCk8ZbPBMzx8qQ4/7d36H5eKYrjl00GoboafkdzBEVGUfG3GC+Tlysz
         N0aZXLUO4GLru5BAxXYuRE5i6gk4gloizOFCMfo9/WMEIHBrvudIjJ5E/YuX38sprPMe
         KGeg==
X-Forwarded-Encrypted: i=1; AJvYcCW2krTq5yKWPy2rvkQrEZBKn2Iv6RccuI3gguE3/BdkbY55AjrdsgiAJ9FiOF9L2NkJDwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUk1pAWRSDNPpcg1nAPfjIKAP0hTd4BqnysJ3ZoYmjX+SuXgdL
	VyCVbxe15AsVCB8OKG2N5XzPl7f+c53MofAdAAWIqPlSf42VNn0t21NePKEgKTieEEM=
X-Gm-Gg: AY/fxX7K4t6ZxzNJHu32DlSnfxeyYKwVliUm+n8d1H6MbAqUgmRBe3CV78gP9WubFqK
	DevIpZ27IR+kmQDT0Uy9nEzDAKxSZdMjZA3rUiBDwplgAOBOiSMQ+w7nZ487lMaDQvHdAhZUcuT
	+S7l08m0yj1du4NlCC+CGbyEsKtnYeDcPbGyPYlxNhYb4qQYc+7j3ISJrsX7uOTHJgjloPfUIlC
	x7nzz2ZEj1PMXoywXxzXMR10oAr9YpTJ26PWwR1wfMlUHGq7YAQltAGhHFEryZ1OPlxz6v6TieW
	XRpb888bYVwJCcyFtROpM6ehsk7IpOn4RWloeqek/8dU9u+I8IZqHjTGgaRSZi70uuhlnstTjjy
	NY5Zve26uvlQ+dRUNs8vZO+Nbs2JjEY/6wRo0KIUWMGx5DT/MRFTAbU4OSII3gFeFWk0ZMynsSk
	bPNHE3igxNu1uc6GddFqNqc1vCudn7xTp3R1DhFk++r1Ey/cNucGBQBK8Imt0+/xA9DP3fjP5/M
	LPmtMZ6B7NgGZYJaMLBADPZtMZVXNHhINElNp6CVNHRRuV0VMv1pr8RF7RUeMSD5BRvvo1Nlug8
	WN0=
X-Google-Smtp-Source: AGHT+IFD9VEfhTkWGAUJ+KrkgUpiheofAxrSZVwNtEffu0+8gx+hrdlGu9tKXSDKwQO+mDr4xt9mXg==
X-Received: by 2002:a05:7022:3a83:b0:11c:b397:2657 with SMTP id a92af1059eb24-121722be81emr4954809c88.22.1766180747284;
        Fri, 19 Dec 2025 13:45:47 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm10260116eec.2.2025.12.19.13.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:45:46 -0800 (PST)
Message-ID: <ae957ee5-cb47-433f-b0b3-f4ac8ec7116b@gmail.com>
Date: Fri, 19 Dec 2025 14:45:45 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bart.vanassche@gmail.com>
Subject: Re: [PATCH v5 08/36] locking/rwlock, spinlock: Support Clang's
 context analysis
To: Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>,
 Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Josh Triplett <josh@joshtriplett.org>, Justin Stitt
 <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-9-elver@google.com>
 <17723ae6-9611-4731-905c-60dab9fb7102@acm.org>
 <CANpmjNO0B_BBse12kAobCRBK0D2pKkSu7pKa5LQAbdzBZa2xcw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANpmjNO0B_BBse12kAobCRBK0D2pKkSu7pKa5LQAbdzBZa2xcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 1:02 PM, Marco Elver wrote:
> On Fri, 19 Dec 2025 at 21:26, Bart Van Assche <bvanassche@acm.org> wrote:
>> On 12/19/25 7:39 AM, Marco Elver wrote:
>>> - extern void do_raw_read_lock(rwlock_t *lock) __acquires(lock);
>>> + extern void do_raw_read_lock(rwlock_t *lock) __acquires_shared(lock);
>>
>> Given the "one change per patch" rule, shouldn't the annotation fixes
>> for rwlock operations be moved into a separate patch?
>>
>>> -typedef struct {
>>> +context_lock_struct(rwlock) {
>>>        arch_rwlock_t raw_lock;
>>>    #ifdef CONFIG_DEBUG_SPINLOCK
>>>        unsigned int magic, owner_cpu;
>>> @@ -31,7 +31,8 @@ typedef struct {
>>>    #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>>        struct lockdep_map dep_map;
>>>    #endif
>>> -} rwlock_t;
>>> +};
>>> +typedef struct rwlock rwlock_t;
>>
>> This change introduces a new globally visible "struct rwlock". Although
>> I haven't found any existing "struct rwlock" definitions, maybe it's a
>> good idea to use a more unique name instead.
> 
> This doesn't actually introduce a new globally visible "struct
> rwlock", it's already the case before.
> An inlined struct definition in a typedef is available by its struct
> name, so this is not introducing a new name
> (https://godbolt.org/z/Y1jf66e1M).

Please take another look. The godbolt example follows the pattern
"typedef struct name { ... } name_t;". The "name" part is missing from
the rwlock_t definition. This is why I wrote that the above code
introduces a new global struct name.

Bart.
