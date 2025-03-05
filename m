Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD421E5B9E
	for <rcu@vger.kernel.org>; Wed,  5 Mar 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163778; cv=none; b=onRKvnDE3SE6mQrB08LXpxu2RxtyvleJzN3uSTOnO38VKYwn6MQkMkkZ88k3wVsvPAW+s1oxibBWNF+WSee0mss7vXIxKwxeDuD5uq5nCGDtyWhFr4TKxrJof7FhCPgUy0UYJwLadsrUIInSZNfLD1MwZkqZ4E8s7juR33mXY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163778; c=relaxed/simple;
	bh=tclfnaQ+78uJUqE4m2J8GwrNwDst3SKOWGjXQTac2LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW+Idvi8PDfdPIq0h0a630OvO7XRtu4CsIIW2i9OndEc+odnebFOya+zkNi9XmBt+MFYWpvYvqzy8q8dlQi0Kxl5YpBhI9cHrVFT0ZDRjZ90CT91D+AdrPcWT3LnZFEdwPx0dQPJmiYNQUuSKZSjH9V8xOlD07r5+Ef06shw9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRucgZbg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRucgZbg"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390e702d481so3008725f8f.1
        for <rcu@vger.kernel.org>; Wed, 05 Mar 2025 00:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741163774; x=1741768574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfQXwUL3Ydz7mR+cjRUeO/xqWRGS7uJqxxJMkaNfgT0=;
        b=mRucgZbgodwpnJ/LEwx6AquTZQHVsPy5Wt7PkYj3/3iuVXlzlfYtpsV5C2wYRBmbjw
         3EoNk2BCWG1GAhSntBmEettOHYWTw2qcwjQFFgUL1MBd4YosDoTysLdpXDjaGw4dS5/N
         Afz6ZJnF3JarVvhJSD/cRh7RFuYL7ulENxsauISFdD0pBKnaBVNiVDZ1LdAb5/NKn++B
         5iWGnQFlmfBbr4Dr/jZayWeKdN15hWB7yQvny/iE3hdmhtMSsRKqZKIQU6aD7hHmimWU
         5BgNaV21Aa7Kck9JS9G6E/zL3yh/A8g5Gr1dvG6j87h9dCZniNs542brkWusvVD9JHQo
         W0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163774; x=1741768574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfQXwUL3Ydz7mR+cjRUeO/xqWRGS7uJqxxJMkaNfgT0=;
        b=KtLrrdkI7BOBowxhprEvlN6ucEAeztyuArSslYg/1bWuCsvJFXY1MMPXyk9tVhOK1H
         MFZ7BvbdzFV/seMLtYUO+TeU215SXJ2i94NSMobQrYGZR0RNuaWMQ0RG50ptc24dNqrl
         nhDYPgi8+TN9Fd8fbkLn8rhM6s2uHJoTnwcHHeuslJ8Ivfg9mOSgi/tv0NseHfWH2clG
         bBio6vSw0VgpscbN3w6CrZpz8u5jR6JTvZT7WuQVxlTE+B+hch8L/pKeOcF8zUdjn2mz
         E9lYhKn8xGYC7vGbA5DLvVWDxn3g+iorI5C5PJLf2M9IUTxcScG/FVXvB6qkYTLzDuWy
         qNiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIcy9/mP9KpZBAHYrug+A4a8A0Rzo1Z18e9/TiJ+UFe2LKkSzdxY4poIw1m84CtweqoSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4UOry/MqV4MelUlvX0SPHM0KczhXwEj4fFlCrSHfD+KhG2Lu5
	QdQIaDOoUubliCK/H3HXzBMZTd3IQUreKnjxW4a8uKN9+C4he7RZWJ3oOE5UZ4A=
X-Gm-Gg: ASbGnctj3e2EaeTfRaLGufkZ1OWzJL0DL9y0ARVPPZLfADS3t7eBTS4Vat7WaMK/iXD
	p/fY8xHk/4pjbydWNpU0DOklLCne/N/ACYSLEwtsDwA4hh05WlBDI+k8tuw1N2YZUvQ7Kxh5H5S
	2kRAQvRghWJvZ5Nanj4fOHPQMkzlAydLlFC9bNoPsT2VhNzaA8HpE0kyX1lQZ7AKo6ZEARYqFfQ
	XZPXnhyTtVpmhrKYFnplMig7UhphFrn3bVu4VRSOJ+uAkkf479JdrWDR51Zka2sjLw3Ujtf/GED
	cnqwjWEsQxOnGLcuYPKGrWCMhe4tZu9rWs8ovI/cUzBRJXhtPw==
X-Google-Smtp-Source: AGHT+IG1TdRy5Kvu8p1cmT5U4TYJbrUoCcVGa1tX1dkQIqW9WiR2lgUQPgvjP/3zB9IzHIHCvQwYww==
X-Received: by 2002:a05:6000:184c:b0:391:23de:b1b4 with SMTP id ffacd0b85a97d-39123deb51dmr497486f8f.45.1741163774150;
        Wed, 05 Mar 2025 00:36:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e479608fsm20564933f8f.14.2025.03.05.00.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:36:13 -0800 (PST)
Date: Wed, 5 Mar 2025 11:36:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marco Elver <elver@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>,
	Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, rcu@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 01/34] compiler_types: Move lock checking attributes
 to compiler-capability-analysis.h
Message-ID: <f76a48fe-09da-41e0-be2e-e7f1b939b7e3@stanley.mountain>
References: <20250304092417.2873893-1-elver@google.com>
 <20250304092417.2873893-2-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304092417.2873893-2-elver@google.com>

On Tue, Mar 04, 2025 at 10:21:00AM +0100, Marco Elver wrote:
> +#ifndef _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
> +#define _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
> +
> +#ifdef __CHECKER__
> +
> +/* Sparse context/lock checking support. */
> +# define __must_hold(x)		__attribute__((context(x,1,1)))
> +# define __acquires(x)		__attribute__((context(x,0,1)))
> +# define __cond_acquires(x)	__attribute__((context(x,0,-1)))
> +# define __releases(x)		__attribute__((context(x,1,0)))
> +# define __acquire(x)		__context__(x,1)
> +# define __release(x)		__context__(x,-1)
> +# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
> +

The other thing you might want to annotate is ww_mutex_destroy().

I'm happy about the new __guarded_by annotation.

regards,
dan carpenter

