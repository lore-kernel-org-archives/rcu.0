Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1132B994
	for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180065; cv=none; b=j/UCcW8pE01D+LDM1Ym3bapPGpiF7YFnGOfZunQbPNgMFYNE/RJ0XwIntvz4u5ai46jFYFIdLVWcUQKkheb6vF9fknysOed9lZ/AUQnh2mj9uLLI8fiI8KCucDEO9rPFzYLjc0ujq1Emgspn5OGQLGameY0agHJb6gfejo6XpzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180065; c=relaxed/simple;
	bh=nyd1g6CvIGlrKzYvOsHmwPnVPCn93E0wfS69PVJVpBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SU2YBI0fW8o5tiU0EezEd72uwqifrK69OQ+YRz8AWnrZ25kR0nDdlpZ28qJW1bbAMvxF08JUWFxFXQnDL/H0EcuEmzBRGlrpSmqxllTef82H6Z/rVONU6QW5nyQLr/YLTavj5xVy6OJbaE/4PDuPwK+mJogUrItK19o0/5wRbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRelEwD4; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRelEwD4"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c03ec27c42eso1251991a12.1
        for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 13:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766180063; x=1766784863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t32XLNtILrSHOTsv1yzEwE7SsXS6lnNnHJdt9fn7tL4=;
        b=gRelEwD4GoWlWOkPaG7BOmN8aT/9HPaC9ND1AqE2rqeR1LSEmj1uB4CPOgI2wL5rRJ
         W52vtmHxEcCK5ZC1IrQSt+k9jGxVvMAgUVGgBNBePo3Iw2kwPnrxSn0ICFyGEhlqpLk/
         7Ly56ZOn3LFbs/0GivqzTKiUjLXNInfOHUmUyIztg5z/ezsSNpeeQnD3xe9GcpJerOLj
         D/ehegZSV5Q0SBO1XajgZ2bYxvu9VhcPJXXXr42VWTOC1p79kzIkdlv7SC3Qn8XrShJQ
         7jEcSXVWh3lP3lGg91nqkOJaGDvW6VpJln9PYYRhufqtxdqJGnmlRuO05cQAuReP8LQD
         i5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180063; x=1766784863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t32XLNtILrSHOTsv1yzEwE7SsXS6lnNnHJdt9fn7tL4=;
        b=pFrZv+7mzkZbKsTlCgRq21r1iY1r9j1OZX1hlwqkTnB5+ljeUKVoHN2pYPQdiixvwE
         pG3n8Q/tebkPtOwHAyLxP0T+QiD7SqqJBnjAZ9pZhgItAQoaKskCLl8XW8CZdYyQ76RQ
         TEhxyC1cS5+oQxfuc4wx0p557XB2cXCZ6Q4s/rmr7XpbM9/Bc2JIQA7lIDNdQt1Qymr+
         Li4GsHL5lyNX1he3J0b+jobOxeaGln3elG0CDw7Mjq0YVzkdmcrIO9JIS7uP8Sqi1SEk
         DU8AKwJ5fwiRDylMs2AZpxCfDbJM60n+BOsmhrh9R3crnBpWxSf3/3KrfzMjTnnHYm+8
         xVlA==
X-Forwarded-Encrypted: i=1; AJvYcCUxX+3NB48sEwSw9pwQ6hgEuZfjHBroiL2L798NLtUKgcHHuzcoWt4cnQMerHJyaflydPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8ZQkiGbmEhK3uFR1eCVu5nQM2L8F8EuHF06mmh2sa2ZaNKaF
	h+RlFYQ8NgDx6Y5URO5WX4UPLVGAqVi0VaefV1XdcFsIbgqeVgilE17p
X-Gm-Gg: AY/fxX6dCIJ/0fc/YvHQsSC90wocr6WFerfYXs5c5n1m6Qalb0foFebfYMKjJhnnUfP
	Ks57slTRJMk+I0Z1APCZBvcxKWl5RzSc1go85ADK3G6OIJgZK6n/zYDp+aHje0dQpOpWw7k5F8g
	po96rTYkhyskPhqvGpF8MsVwOE/Bd+U6cEkqkcbERr6WgflFQhCjdvT37ARLNNxwr4s7lCpTKvv
	EM6HBM7jWZ2PgVEIMIQsJuY3A2oxgn0JxnCcpotbtI6vtfqT2wMHkjFfE4hKDjJWbeTJtoQcK6M
	5dfdLXSkDlV9vqKHiFjHfY6vuZ4HxPygNkdioFrZjv+hfpUvhQ/1neLz/djuKw3N3vO2LdFBOmv
	rnI5kjt5meZ3L/mIafHxH9d24e0P9B0wGJlltykdP6531FMuBk7pizgU0cjjTB0ZU2QKPP/IYpb
	eh1+wcC5g86jZb4zVrZ0sI6+q3XAUoRnOjEy0nUIc9iARhZvdshQYIWpP1o+3Da/hyoRvRyH07l
	AMZBjzfmyR1oqSwB/fkL4gKYxaC6NN8tLKimobS2Tv3ZbAPypu0x4nDmOd6q8U2Dq2am0qk8e5M
	YKY=
X-Google-Smtp-Source: AGHT+IH/ZQYDLQv8GePcj2Vm99oLZ3hFWnPTlzcp7/sSDr5k1uCEDV2wgPs8dBIcnq4Eb4hflvIUSg==
X-Received: by 2002:a05:7300:b54b:b0:2b0:57ec:d1a1 with SMTP id 5a478bee46e88-2b05ec745e9mr4652797eec.25.1766180062475;
        Fri, 19 Dec 2025 13:34:22 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm10155463eec.2.2025.12.19.13.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:34:21 -0800 (PST)
Message-ID: <0088cc8c-b395-4659-854f-a6cc5df626ed@gmail.com>
Date: Fri, 19 Dec 2025 14:34:19 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/36] locking/rwlock, spinlock: Support Clang's
 context analysis
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
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
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <CANpmjNO0B_BBse12kAobCRBK0D2pKkSu7pKa5LQAbdzBZa2xcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 2:02 PM, Marco Elver wrote:
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
