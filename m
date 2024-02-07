Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB01E532
	for <rcu@vger.kernel.org>; Wed,  7 Feb 2024 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325562; cv=none; b=dtFS1syI8CWC6++wZJ25hxXOQDImggv4bVQBILif4pyPclh5cPATqKOEzP27TBjbGUQFxNQnlCL6OxS80bVlCgB7ZPTlMsuJ+HwbNpzW8aOSUAfCrveP6qXG7//1JgPXEqSmw7Do+3UfTmzqeAQYA9gY/lHKf2/vuZVvEpBotMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325562; c=relaxed/simple;
	bh=nlh4Mgnza5YhLOxSvbJ1X0q4Gts3r1milWmH9kxe00Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeacENeUaJh4dut9oN2EVynW4+q5dkKwHyTqpP9smo50SpYVptSsEt7nMCCLyFDUzMFkvOnaLeZYUmaLZrfUZLOF5aTWC2Ds01XNuZvqKD9pJJ61VrsvKGtNhHT4BiZnUxo+26o43gaY8TupK9+ZfHNjMHC0HiO4/lqSFplFsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ll4enzzD; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ll4enzzD"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8FB9940606
	for <rcu@vger.kernel.org>; Wed,  7 Feb 2024 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707325557;
	bh=ftRq5JOshv76scLU55oGqJHnOPOtf0r0JrLW6ZkAeiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=ll4enzzD8f2V2nr9TuB9kI6uuajg+n+vlXUW+p4PNywPeGa6aknvt/lNwilK5ChSH
	 fcBx4C5RINQX85d8xWBX+XFdM2TVpDCXPTD3AHoNULjoB5BaHpwPPw9gMIj10mCMhb
	 bwLutj6ICzjMl3c4R4VwMNwe/UWnQRyX3qYqVDQATxrGGxhIu3w2idYbvGwbWFC019
	 EPtYl7wIY4gpPLuJ69U22YAs7cUDvp+5KipqdrlBBXr6l4M2WE+XIZY9l/C6YiAaIS
	 kw/xWEXL3yYv+D8fxm4ZJu5JC3G5HNN5LOwMpTKUIXnZV9Sciydi+OZ9aUAOHzIC46
	 CBiM/9V0sq0tQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2bc65005feso65107566b.0
        for <rcu@vger.kernel.org>; Wed, 07 Feb 2024 09:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707325557; x=1707930357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftRq5JOshv76scLU55oGqJHnOPOtf0r0JrLW6ZkAeiQ=;
        b=aTg0vJBORh++DpqZyuykE6ICDhHoPQQ6V9YI/c/zZAXn7z3R54gkiJqYdzPJ1B9T1q
         IMxOCKAnEeUcrsKIk2PwY3t8Fde3JlrdZF33rYC4q9Csb+Ys/3XJNY1gmTRX+TERSJcZ
         ZtoA21FShl9q1XxxzgA0bQSz+zmfgONMg4NwyENzs99MCnhSio9OA0n8T1uutUiB+2Ik
         n9vGDeQrYBcD1Qwuix9kiVIwJLHjUYhIotPGF+ND8niN/j8yUqLjAM1Td5S+gsKlcvoG
         sq24F3cGM9SBlHxlFgap53b/VqHLQLqf+KPnMkx6rCaoHOftMqbMVDZjc69x689U6UlR
         62Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXPXa40WoFyaqT/34Yaz3OMbuD3xDiNvnp69SUNZqrX4/a/gXJ+NsNH7fYr6AiIdWI1kWFtQmBcrqFcV45XkWTrr/ro
X-Gm-Message-State: AOJu0YzNbazEJtOHuVco+c/RQmu++oETvk0lfNt762OXBCj48BpS0cnP
	G2HvcIrdNMxKpwE3sBXWRqYiE7foYXoQw8ZpQ2FTbAtM9vy4FQj6SbHL5YXwHr4RKgbR5mp2hAF
	x6jb89Q5vGQZpU4JNPucWLoVcsALa8GMS9Dduzunq2Bw/X1LZjHyhfHTqcq4SZv4aLg==
X-Received: by 2002:a17:906:a89a:b0:a38:920f:7783 with SMTP id ha26-20020a170906a89a00b00a38920f7783mr1043182ejb.73.1707325557198;
        Wed, 07 Feb 2024 09:05:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR9W0u7RcQpc7sSHjC8yLElo3Ey6xuo/Iiwzm+UWZzGWVD+ylzgUl85yseEI972ChT1JxQAw==
X-Received: by 2002:a17:906:a89a:b0:a38:920f:7783 with SMTP id ha26-20020a170906a89a00b00a38920f7783mr1043170ejb.73.1707325556870;
        Wed, 07 Feb 2024 09:05:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbqs+GP5CP2uXIVoZ3vslfW+KImTc1rgoH6DuW1kloOsiaIemFzoLhDoaxqEgSMz8QP9/dcO0MEHNsHUUpxpv33ilNtRRiGVlHI2O6cQ7ihXk39dMgkGR9MUPsUjs8rAAZgvcZm2V1tD4DI4BgoxJdhErHw9CbBE4ILGx6
Received: from localhost (host-79-53-78-93.retail.telecomitalia.it. [79.53.78.93])
        by smtp.gmail.com with ESMTPSA id rf19-20020a1709076a1300b00a3890e2389bsm480583ejc.51.2024.02.07.09.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:05:56 -0800 (PST)
Date: Wed, 7 Feb 2024 18:05:55 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <ZcO4c6nxemyxRFz3@gpd>
References: <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd>
 <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636>
 <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
 <ZcJxhoNpkTM7LnOr@gpd>
 <9f9b6885-6d9d-4f30-9635-49443e1615e9@joelfernandes.org>
 <ZcOwRsEhbQhGv9X2@gpd>
 <CAEXW_YQN=Dm4TXv+F=Q4bfnKWn1Tv52=8hz50JLkbufcM5hUpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQN=Dm4TXv+F=Q4bfnKWn1Tv52=8hz50JLkbufcM5hUpQ@mail.gmail.com>

On Wed, Feb 07, 2024 at 11:52:35AM -0500, Joel Fernandes wrote:
> On Wed, Feb 7, 2024 at 11:31 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> 
> > > The actual number of callbacks should not be causing specifically the
> > > hrtimer_interrupt() to take too long to run, AFAICS. But RCU's lazy feature does
> > > increase the number of timer interrupts.
> > >
> > > Further still, it depends on how much hrtimer_interrupt() takes with lazy RCU to
> > > call it a problem IMO. Some numbers with units will be nice.
> >
> > This is what I see (this is a single run, but the other runs are
> > similar), unit is nanosec, with lazy RCU enabled hrtimer_interrupt()
> > takes around 4K-16K ns, with lazy RCU off most of the times it takes
> > 2K-4K ns:
> >
> >  - lazy rcu off:
> >
> > [1K, 2K)         88307 |@@@@@@@@@@@@                                            |
> > [2K, 4K)        380695 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    |
> > [4K, 8K)           194 |                                                        |
> >
> >  - lazy rcu on:
> >
> > [2K, 4K)          3094 |                                                          |
> > [4K, 8K)        265763 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [8K, 16K)       182341 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                       |
> > [16K, 32K)        3422 |                                                          |
> >
> > Again, I'm not sure if this is really a problem or not, or if it is even
> > a relevant metric for the overall performance, I was just curious to
> > understand why it is different.
> 
> This is an interesting find, the number of timer interrupt executions
> looks roughly the same in this histogram so it might not be missed
> cancellations or such, so it is not clear to me. But it is worth
> debugging and we'll try to reproduce your results.
> 
> Some more theories from our internal RCU discussion:
> - Could it be another user of RCU (call_rcu) from an unrelated hrtimer
> interrupt callback that is causing a "flush" of lazy callbacks?
> - What does the distribution look like for
> do_nocb_deferred_wakeup_timer ? That will have to probably be made
> non-static to be picked up by bpftrace (If you could try that real
> quick, appreciate!).

Sure, I'll repeat the test tracing do_nocb_deferred_wakeup_timer.

> 
> Slightly related, but one of the things we are wondering also is how
> much of the overhead for your nohz-full and lazy-RCU test (on top of
> baseline - that is just CONFIG_HZ=1000 without nohz-full or nocbs) is
> because of just using NOCB. Uladsizlau mentioned he might run a test
> for comparing along those lines as well.

Just to clarify, "lazy rcu on" results are just with rcu_nocb=all and
lazy RCUs enabled (and HZ=1000), so without nohz_full.

If I enable only nohz_full=all (without rcu_nocb) I see something like
this:

[1K, 2K)         	294 |                                                	 |
[2K, 4K)       	      59568 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[4K, 8K)         	368 |                                                	 |

That is like baseline result / 8 invocations, because I have 8 cores and
only the timekeeping CPU is ticking, so that seems to make sense.

-Andrea
