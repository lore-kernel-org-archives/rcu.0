Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731F28134F
	for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180565; cv=none; b=eIRjgE6rxiIjGyWl8m/eimeGfEjhtwzvtKFnTD7ZH1bzUCzdLPmeHey1SH+rE1t6CGsUfDJa1HjhjiEmHGNrfayoz14ieSE/e3G6MnRteUG4xX/7Z38OOyDm2IWF+uos8l83BAB6Uznsa1K3cUbEYVTEj2ij49s0ZSd3He73CHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180565; c=relaxed/simple;
	bh=XXvUIRo6jJ9ogO2QQaUCxttK8WosB2XGObI8UYH72+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQ7MF5OYarzT3bGesjhYmooTZMRFwU7FJOkH8o2F1TX+DZmDAj2e7byNL2m+OAKVii5rRYJdbJ2v8BMARCcmglG73wPNUBe7f4YEBs1X/BqJHPP7w3dihbZHy0ZJJmrgRsR6sB1/ct84/iyyNe7V1M6N8UnTXDVrtTg9uq8qPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOj/rZpt; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOj/rZpt"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0b4320665so33213805ad.1
        for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 13:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766180561; x=1766785361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhB1Fco/aAscGV7BUmHv+KRyMsa6iylEkhRycjuIJTw=;
        b=AOj/rZptNUFI/4UnRqR9fG5FQ29cGUrYlcJJx2lflJCke/Y/I28A5KMi4N1CfFrm3L
         ow86AIq0BJG9HpLBXdf0gflqQQC5t8cN2KiV3kkBODaly4qmcOX5yvk80RVXbtRifmoH
         9sjvd9xJZDmyRyDGilORjblWWQMJNU6Agw7WMpFLYUaBksDg/a+fjRiH+L1qrHNgzxee
         Jc50o4OHuJWtqRFIa+GTKNf7qG/gwNOG10jYe9HOjwMv4hpHQfmChvlC+4bxyS64Zx7D
         8j1dm92dY/SjzI8eCA0tkgzlHwdV1ZCIC92qmEFfsCZGLieEWuaYI8kDGDZ5baKWEVWa
         OFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180561; x=1766785361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhB1Fco/aAscGV7BUmHv+KRyMsa6iylEkhRycjuIJTw=;
        b=MprvZ+FEsnfUEp+ed4MFqLtjZpM3ZXic4LDotuL5Svae6dPV47/bzbp0FcPzrWJDNA
         oDrsDDQ2fvYfkALbvppRljhJZCG8cubqoTTQO9UuBKx+h9imgP9a5q+vFtqiwH7U/Yyf
         Txxi753gBPxNGeTsieHvR/F96tju5/DDt9eZzmGJPngvYi8AdF9nqJQC8OXpDYQulFLQ
         8z9EPSx4LGnF4G0DbPERYHJEsB0J2BYrs1gO6c6YRM/IweQAOjaJGpSE+PDkYPDNJ+V6
         f/jy587DCICbBzEZoYGmm7a2Dbea5PB9mZ/40kgqHEWAoInKLgGTeLdut/hj7dYNNgce
         mYuA==
X-Forwarded-Encrypted: i=1; AJvYcCXkG/7sI4NKkHNsMfLHYWPvepiN7BftOFRKMRsaEL8mSbmSqzLRPktoot9QFZzsbJfo04E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx13ZDHMgorO2Wps2THINdAYwPyrHRm+1Sf9xp/3jKYoZh5vvPW
	a39JTdKbdKyAraA5Iv9fRCO3MHWEaP6gFEUMmhtlr2CdDdtYUv+w0HMn
X-Gm-Gg: AY/fxX6cx6owYrpi0R7V8H0Wyd+VRK63wnTZhYmQxrBpRivL8FzZ/wAHo12kcpyFKWk
	Y7OAqskhIHZ7y/ygAc9pN3jZMhxXBuVI1FShqFOWvHZXP1innUmGGInc6IsBl+6Q3Ao3H6AZ7Mz
	+gobUsFqfFcRIwqkNcJUOL/l2WBhoVWDsoMozl3OI/OmTQfskE3kswJ1LKERkqT2rnqLrCwP/Tc
	pyeVUkBBEV//9CWN/pycr4GtLiJG3H7+FmYO2RJ1c5dSeIusQeTMaNtamxcJ7vwUi3mf+8CPiDg
	5Wz7o9y8S6noo1ehiqbDpOXtMGKFLRBZEP3H2o9B2Nvbj8Ml/ng9spPlchLMHtSw0rdHe5p9Nl+
	KuBwxl8LF1PSkuUS5NuSmb22dLJRnVL0wBoTK7AXGDYobBbmJRhqs1WimXjRZrgd6rfYJ64b+rs
	NtcgdD8kyf59pGF0pDv2ss+bOmHf+t4lOghUCnkmcVZAjwZgCrpKqFrlrMs2U033lnOxT7CfxKJ
	w0ETRQJ1nct+nybA9vaBQcLakevNbiXtimmJu8xz7FFGg4xeSpb+o6k2fp60r9q9aRDP0Vmdr0i
	CAM=
X-Google-Smtp-Source: AGHT+IGTM6mjPPfNhqA9HPe48U2bDECheHzAzGuJpcTxojW/wC3VfdWLu4jNEE4Msq7vw7t+QoPUtw==
X-Received: by 2002:a05:7022:62a9:b0:11b:78e6:8323 with SMTP id a92af1059eb24-121722fd212mr4438541c88.37.1766180561251;
        Fri, 19 Dec 2025 13:42:41 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm11636083c88.13.2025.12.19.13.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:42:40 -0800 (PST)
Message-ID: <9af0d949-45f5-45cd-b49d-d45d53f5d8f6@gmail.com>
Date: Fri, 19 Dec 2025 14:42:38 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/36] compiler-context-analysis: Remove __cond_lock()
 function-like helper
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
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
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-25-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20251219154418.3592607-25-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 8:40 AM, Marco Elver wrote:
>   Documentation/dev-tools/context-analysis.rst  |  2 -
>   Documentation/mm/process_addrs.rst            |  6 +-
>   .../net/wireless/intel/iwlwifi/iwl-trans.c    |  4 +-
>   .../net/wireless/intel/iwlwifi/iwl-trans.h    |  6 +-
>   .../intel/iwlwifi/pcie/gen1_2/internal.h      |  5 +-
>   .../intel/iwlwifi/pcie/gen1_2/trans.c         |  4 +-
>   include/linux/compiler-context-analysis.h     | 31 ----------
>   include/linux/lockref.h                       |  4 +-
>   include/linux/mm.h                            | 33 ++--------
>   include/linux/rwlock.h                        | 11 +---
>   include/linux/rwlock_api_smp.h                | 14 ++++-
>   include/linux/rwlock_rt.h                     | 21 ++++---
>   include/linux/sched/signal.h                  | 14 +----
>   include/linux/spinlock.h                      | 45 +++++---------
>   include/linux/spinlock_api_smp.h              | 20 ++++++
>   include/linux/spinlock_api_up.h               | 61 ++++++++++++++++---
>   include/linux/spinlock_rt.h                   | 26 ++++----
>   kernel/signal.c                               |  4 +-
>   kernel/time/posix-timers.c                    | 13 +---
>   lib/dec_and_lock.c                            |  8 +--
>   lib/lockref.c                                 |  1 -
>   mm/memory.c                                   |  4 +-
>   mm/pgtable-generic.c                          | 19 +++---
>   tools/include/linux/compiler_types.h          |  2 -

This patch should be split into one patch per subsystem or driver.
E.g. one patch for the iwlwifi driver, another patch for the mm
subsystem, one patch for the rwlock primitive, one patch for the
spinlock primitive, etc.

The tools/include/linux/compiler_types.h change probably should be
left out because it is user space code instead of kernel code and
the rest of the series applies to kernel code only.

Thanks,

Bart.
