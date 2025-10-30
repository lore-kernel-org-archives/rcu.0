Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309B2F6591
	for <rcu@vger.kernel.org>; Thu, 30 Oct 2025 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819919; cv=none; b=gfU0SePY8wVicrW1P6+qAh1olIeEpJoPp768A9bkm/vi1pu+MTMRr2G3uFNNFNLq8PuSsTbKSmKgTIe9Lfv9kqQ31B9Io5jvh4XXffB2/ldVKhui6vRPF8CRgJkgSGvczuCcI5kztcBlTBF+cekbuhFuAZoMJ5RnvtZkOITYHu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819919; c=relaxed/simple;
	bh=/OiTwmyjWBCx0q96Gsr9SY27ybAo0GLz8Cev2v1IhyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBvRBhoJDIqLJoyuX76duMaxQBzm7v/EAEdqjuLPZ58Iq3SvlKNycdvO+HE/AK754MZfvA83U802+6oLmnUorAumRJhuYTzxMnrKrEIwTGm3ZEISDbmLPjVbQ2XFAUu1Lf+ys7xjf2M42tPnEBXQ1yT9kfLa2xOzQ+8pqQTLFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MNEEIXp3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MNEEIXp3"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3c82276592so15106666b.3
        for <rcu@vger.kernel.org>; Thu, 30 Oct 2025 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761819915; x=1762424715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTgIsc3O+wDypaKqBlwZIo86kBPQGfr40arZuVCJ75M=;
        b=MNEEIXp3U3e0BlWXVNtco0TH/amTu+TWkWbkMT7o3svpJoWGHknjv0tQvlPVZErEpb
         gttDBZ8rFQUqABpCwyEN46K67Dy70sW3C2i7qddNytI8b38Bsa2naTSVzL2l27CGHhAc
         IZa6tvQeQsVLiSlDH/LYcokupeT96buvLXhSAECt1EtD5IrHWHuAquKgCRdMvpLYxDKy
         nBBckInWtiGQZvPlCGpnEw8FdtKP09FrBU++uDTRIXmZ/Hjj0nKSPRen4hNJZqQ1OMYb
         HMLQrFZvSOfO3nOwZ+oaMtPsh9hHwmvU0DjntMRJf9wjMq/z6zjXb374d+BXtFsqSwOu
         dXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761819915; x=1762424715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTgIsc3O+wDypaKqBlwZIo86kBPQGfr40arZuVCJ75M=;
        b=WeOyKChOSIsY7Ke8MGt2pE76/Lp8QGCaEIpa9fFKf2m9dnsPF6dm03lqYqiOUrswIL
         1A07ht/qkGQM6BpJ2ulvbClYU7c31BBVEaYZw1OGX154/Xg9W7Q85MVcZdGMPKxg2CI2
         KQKcC15ma/3ZLk3eLqQEvu0AtvxBj7+0a32YYG0f2r3gqOelREVDQt89xK6sJPfGKtWp
         CIILNclX8fS1l9y6of4ohzySTCbVUfFhye3OsqidtCxdqV6qo6PSUZFapkogOeRQ4uCS
         yGCf7swtnjfrbqA2Au+KSLAl1b642IZktMUXw1lHyVGT627bi+RMUG2FzzzFR+TtWwNZ
         RYsw==
X-Forwarded-Encrypted: i=1; AJvYcCVoJDY9qAizExF2DAC0Q+u1wnWyUl1M+pqTi5YVu55vYcSA9CNWEUQWWmNe2MC1VFUFAog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy74WBI03sE0JwP60reMyYU4AYvwADybvo/PignLWYq+Wrh8uik
	v6tFi/Hl6Fd8TW6JpciBJOAkSpn6S/Dg0d4ZN2fSJ+Mao2fn6+SUX2eVyx3Zgp7y7/o=
X-Gm-Gg: ASbGncs0YVjiK9B/BpYgl8Z3nivUFe97YSbsDgqVr6+oCWbk2aekELjtYK3OGmgUblm
	KaKfv+1H7WI98aabFoVU8U21E5IhFWUrkDM07QNY1HNynqLpXFdhMEcRCriTMNh7Od11NayXAYn
	U+te1aLOi0WFYgo7+mclZyc21BxrH58M6wRY5LBBArf6oSaH0gqJ5/ro3kNnm5w1EwuRCoBsDU1
	17CdniWgZWy9smOV3llP0oO5LMgx6XQ7UvAgeyuolvXmXGpiDxhVPMTsCEr4dqJ9kjsjoADBIsJ
	glwG/IVBEcXQ6iD6EVusKkytTOpXRe5KnLMKeILuTBp+0PL7KYC85WHQxllaFQ8RSZk9e93K6Yt
	MRzStC0MPHSE14UIxsHBnzl6IqLTWObidT9ZMGCCpryEvHNSUTZNzgVMUiw3ED4dt7E/Z6SYrEf
	3c31LJtpwTI7oK81Tdr0BQvOk31AJ5Gsp5nqd6391RoPBbWvnp0B6G22htLDUlDxD9TYSyNErIu
	hkk
X-Google-Smtp-Source: AGHT+IEXsUOIqP3MBMqvuO3EOkZU6BKA34oP58piwLuVoouucxjytl3skX6Ka8nntE+ckkHO79CK6A==
X-Received: by 2002:a17:906:f586:b0:b6d:5439:e668 with SMTP id a640c23a62f3a-b703d55e454mr372826866b.8.1761819915166;
        Thu, 30 Oct 2025 03:25:15 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853c549fsm1728375066b.37.2025.10.30.03.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:25:14 -0700 (PDT)
Date: Thu, 30 Oct 2025 11:25:03 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel
 <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, "David S.
 Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>, Jann Horn
 <jannh@google.com>, Dan Carpenter <dan.carpenter@linaro.org>, Oleg Nesterov
 <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Clark Williams
 <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v6 06/29] static_call: Add read-only-after-init static
 calls
Message-ID: <20251030112251.5afcf9ed@mordecai>
In-Reply-To: <20251010153839.151763-7-vschneid@redhat.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
	<20251010153839.151763-7-vschneid@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Oct 2025 17:38:16 +0200
Valentin Schneider <vschneid@redhat.com> wrote:

> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Deferring a code patching IPI is unsafe if the patched code is in a
> noinstr region.  In that case the text poke code must trigger an
> immediate IPI to all CPUs, which can rudely interrupt an isolated NO_HZ
> CPU running in userspace.
> 
> If a noinstr static call only needs to be patched during boot, its key
> can be made ro-after-init to ensure it will never be patched at runtime.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  include/linux/static_call.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> index 78a77a4ae0ea8..ea6ca57e2a829 100644
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -192,6 +192,14 @@ extern long __static_call_return0(void);
>  	};								\
>  	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
>  
> +#define DEFINE_STATIC_CALL_RO(name, _func)				\
> +	DECLARE_STATIC_CALL(name, _func);				\
> +	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
> +		.func = _func,						\
> +		.type = 1,						\
> +	};								\
> +	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
> +
>  #define DEFINE_STATIC_CALL_NULL(name, _func)				\
>  	DECLARE_STATIC_CALL(name, _func);				\
>  	struct static_call_key STATIC_CALL_KEY(name) = {		\
> @@ -200,6 +208,14 @@ extern long __static_call_return0(void);
>  	};								\
>  	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
>  
> +#define DEFINE_STATIC_CALL_NULL_RO(name, _func)				\
> +	DECLARE_STATIC_CALL(name, _func);				\
> +	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
> +		.func = NULL,						\
> +		.type = 1,						\
> +	};								\
> +	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
> +

I think it would be a good idea to add a comment describing when these
macros are supposed to be used, similar to the explanation you wrote for
the _NOINSTR variants. Just to provide a clue for people adding a new
static key in the future, because the commit message may become a bit
hard to find if there are a few cleanup patches on top.

Just my two cents,
Petr T
