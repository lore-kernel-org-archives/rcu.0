Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB19274676
	for <rcu@vger.kernel.org>; Sat, 20 Dec 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766235130; cv=none; b=nTznj+0bz4V8GiYXV+QCUKUsky/yJeUfR8kFy1TArtZwMgOqrBrQoziW3LgLGGOTmMLw/MurYPTv2fe8MPpIo18hA0ilvhLGcCKZj722gMenlBf1T+EKJLXsFkjvfdPC0h1cUDnjMIqso4wxQ/J9Y985jBq+0/qrrEiLJ/BSpTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766235130; c=relaxed/simple;
	bh=wkv3Ho3KGiVJkt5Z4uain5drk7TOMSZYfvI9aQbzCrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRGuhUZrz+76N2b09BgWhjtX1TlQNHnEoC8kByTj0PQ4b5vCRYyDWz7J+Ex14TLH0CyMsi+gGel4S2DyeYT/Sm7IbMenIFcVCxYbemOxtccT3L6Y9RPqBtFNh8iLaMTOhdb8oR91IUoH82mHSWzby5aw/8oKGbpoBQF5/6visO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4fKfKSKv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4fKfKSKv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29f2676bb21so33208435ad.0
        for <rcu@vger.kernel.org>; Sat, 20 Dec 2025 04:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766235127; x=1766839927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+dbDPICBAvFxThOmxuLLN+XESg+4otRZJCktLSd/IHI=;
        b=4fKfKSKvM1SC6Tzv/bJ7SpdOWrpUGOe+n+A0s4HucJnyJXoUvg0bBqgs3cJDHd9d0P
         fxyPZ1jO4LYfkUJb/NShyPV2B7ey2yft+RzlVDNvS34KL0lvRtgDj8MYBTSJ4uB11TOb
         kJgeX/fWH4r3ZoBCu5rGx9tgC0Almi31+Rg7noxwgSeyltZaSWzD5G26BrXB4I3DxRCX
         yQDd1uSFawTeGBdhklItdKxkhJ5GeWzKj2oZPIE5K/jf9Jg5LMnqMxEaFGTIiDw+BYK0
         QnIBI5evkUDynqRI//PJWAeBUCPNPRR5RX5+KOrMK+tZHSGNK+Co9jfADrmS1yHAKKBU
         /Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766235127; x=1766839927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dbDPICBAvFxThOmxuLLN+XESg+4otRZJCktLSd/IHI=;
        b=WOEbStxgmXsq2oK8L1zkk3NSlVOxjjdbjqmcz3QhRWeH6l6kPFsOahdQytKzLzxieJ
         mscGR0iRGO44BBRzvXE4s9rFhjAfl1OogoZbxkBsgyxyNqGHcTQb9k2wx9Gn0Vqe/9oG
         V3KaFERxWJgwk119gEPw/HrYfygcJjW862Yj7uEnHeY0TRHOaVaBL2BeTDbFxfvtGgC4
         US8KOOHZZojpCx8qLlyUyGSnEYGHqtlFGi3JH9Fb3/StWSgIdBrwLQUFORED0RZQ0J8Z
         E8wjWPTHueiPCcSb0ziIYdVB4/DvxQ9p8THcYCunYExVekegz0jCGWiPNBmHgza//E1V
         HqSg==
X-Forwarded-Encrypted: i=1; AJvYcCWn6vnbj5FzonASwgnPQz58r9YUAKGLqIkOxUKVl+7aSqpjSBnm2L28USGKIyNz6wrgiJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIG7zoYL5z1qGCE0o8pLaX2MYy5EUAG1c5b+IBi8zmTFlpXs+x
	VYpihG2qrctxMi8Zg9iuNjj6ydhgxtQvRoouYaB6AnnhIBODpx9ITK6zG5GeZvtLEnVK/64mT6Y
	YmFvZkwfyY9YWzwu6U+VknyPHxV2pPDzaqx26wdkz
X-Gm-Gg: AY/fxX5V1n8GGiVn3fbnvjjybfzrKx1cOuAv6L6IB7E/sCNPLTACf44hy4yiv6ZmDc/
	65hy2PtoQ7d/s1k6Q2YUmfgO1E19D05fXUX4dpiiYF0xfvdGzXBZkawXVKO3oh/2UycohoHPWuq
	BSwqVHNgRpsjg6Jw/7I40f+TzqvfJDuwoMol99ZwXpW1BjgXq4l4k226aERtY5+yL11wHKaL2uw
	nG6a1TajLKPsNJgpUuOLFzR19OXTzhJ1bqncAxhAHOy3vq3bMUh9Kies31Mv+f+pbnLAJSzrlB3
	t+0e6/r3VgtKm/fHu4gTtYGNrf8=
X-Google-Smtp-Source: AGHT+IFK+Y5PBS3dXibTZfBS01UEAFChnwqe6iaCyTB/4jIaIz5ZwPF8qLO8d7Qf00M2Z85ZCatTVKEE522UP0jz/Ik=
X-Received: by 2002:a05:7022:6291:b0:119:e569:f61e with SMTP id
 a92af1059eb24-121722e12e7mr5961881c88.23.1766235126461; Sat, 20 Dec 2025
 04:52:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-25-elver@google.com>
 <9af0d949-45f5-45cd-b49d-d45d53f5d8f6@gmail.com>
In-Reply-To: <9af0d949-45f5-45cd-b49d-d45d53f5d8f6@gmail.com>
From: Marco Elver <elver@google.com>
Date: Sat, 20 Dec 2025 13:51:30 +0100
X-Gm-Features: AQt7F2ppWjAa_1uLXQb3ar2W4qqqhjA5uP_vsvi-YrCuihuPYztcukGp4Yjpido
Message-ID: <CANpmjNOUr8rHmui_nPpGBzmXe4VRn=70dT7n6sWpJc6FD2qLbA@mail.gmail.com>
Subject: Re: [PATCH v5 24/36] compiler-context-analysis: Remove __cond_lock()
 function-like helper
To: Bart Van Assche <bart.vanassche@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Dec 2025 at 22:42, Bart Van Assche <bart.vanassche@gmail.com> wrote:
> On 12/19/25 8:40 AM, Marco Elver wrote:
> >   Documentation/dev-tools/context-analysis.rst  |  2 -
> >   Documentation/mm/process_addrs.rst            |  6 +-
> >   .../net/wireless/intel/iwlwifi/iwl-trans.c    |  4 +-
> >   .../net/wireless/intel/iwlwifi/iwl-trans.h    |  6 +-
> >   .../intel/iwlwifi/pcie/gen1_2/internal.h      |  5 +-
> >   .../intel/iwlwifi/pcie/gen1_2/trans.c         |  4 +-
> >   include/linux/compiler-context-analysis.h     | 31 ----------
> >   include/linux/lockref.h                       |  4 +-
> >   include/linux/mm.h                            | 33 ++--------
> >   include/linux/rwlock.h                        | 11 +---
> >   include/linux/rwlock_api_smp.h                | 14 ++++-
> >   include/linux/rwlock_rt.h                     | 21 ++++---
> >   include/linux/sched/signal.h                  | 14 +----
> >   include/linux/spinlock.h                      | 45 +++++---------
> >   include/linux/spinlock_api_smp.h              | 20 ++++++
> >   include/linux/spinlock_api_up.h               | 61 ++++++++++++++++---
> >   include/linux/spinlock_rt.h                   | 26 ++++----
> >   kernel/signal.c                               |  4 +-
> >   kernel/time/posix-timers.c                    | 13 +---
> >   lib/dec_and_lock.c                            |  8 +--
> >   lib/lockref.c                                 |  1 -
> >   mm/memory.c                                   |  4 +-
> >   mm/pgtable-generic.c                          | 19 +++---
> >   tools/include/linux/compiler_types.h          |  2 -
>
> This patch should be split into one patch per subsystem or driver.
> E.g. one patch for the iwlwifi driver, another patch for the mm
> subsystem, one patch for the rwlock primitive, one patch for the
> spinlock primitive, etc.
>
> The tools/include/linux/compiler_types.h change probably should be
> left out because it is user space code instead of kernel code and
> the rest of the series applies to kernel code only.

AFAIK, the user space version is just a copy of the kernel version to
support headers that are used by both. See
4bba4c4bb09ad4a2b70836725e08439c86d8f9e4. The sparse annotations were
copied in ab3c0ddb0d71dc214b61d11deb8770196ef46c05.

And there's no point in keeping it around given it's all gone:

% git grep __cond_lock
<nothing>
