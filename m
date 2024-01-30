Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506B065BD1
	for <rcu@vger.kernel.org>; Tue, 30 Jan 2024 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612816; cv=none; b=lrd/hEBP4oiYBB1YaSoRgl6iIGgN5wJevRu3xmpkTKGxM6ckPGiW5V8QqOwzVkflZdItIesayPK0Z3dcImxbh55V0NABsjq/1Ae0FIYRmbxF9KH4HPueZAFiNWKYajfKlGVb6uNNOc0KtfwY3sm0J/lexul3KVk6qAlbaWbMDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612816; c=relaxed/simple;
	bh=hogLsIU8QyBle6ByPh7xU44JzCwWuwPv8m3lUzxkdBs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HldG0cudMus5esXSS84YlC5jCnhPPd2TUs/pfePpZMP7Kvt93W8j0rQOU8a/WJK83U0BKbjMDREZEkcmnJr3YwCfoSRZZHAbLrvpdXap8PJjAfUPwY1ds7BFa6iVQaxGti4jkyvL0cWAq2II+WZ8ZY+sQRIjeywXWdiujkZKbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5IWTat+; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5IWTat+"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-510218c4a0eso4351653e87.1
        for <rcu@vger.kernel.org>; Tue, 30 Jan 2024 03:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706612812; x=1707217612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+lzeFwzBlDJQfNTv+qZ4opBV1Z6HDBYd/f6TJuREDM=;
        b=Y5IWTat+ZdZ9Vn5gsWTwc9OO1ryh2PuggwGti0pO0GPg2TAXW746KgisNSwj3y47ZO
         eDLaWl/1LNGGsS1d/N4Q0yAeNbPF75QQTBZu2UjHQ/llPehDN44znvxnUsP1FhgCxJyP
         97Q8HWDwOjs1rx8Qa1K4X63R+8dbZ8I8kWt2wRUCiiFqZAZ73Uce1rzlHyilF/OVnfER
         kV2Jsxu1TsweMb99fxa3KGJnuCeDauno6kuq9xvYKS3TSEXBAT3KALzZ21cPBr16aczi
         IB38CRUqumenvkmMtTljs2Mj7i2H7dzek+nds8WV8aj3siSMgtLOBQ6IGq6fijowHkLI
         PGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706612812; x=1707217612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+lzeFwzBlDJQfNTv+qZ4opBV1Z6HDBYd/f6TJuREDM=;
        b=dkfk9NCe43HPzuWh/aNbI23DmvefsRzFAp/rObZldyUnCOHJkN3JarjBcuNbnpwiJ1
         WqGQFTxKKXKUHkp4vnbU25gDRi8NKNapKPfPuaS5MtXHWBbt3b5rJ2mgBjPiOYg0+8Hb
         Nk5SBzpWKFBfB3nC/Kh5AwYHsFrQ2XqgK5MBZ7rHGzg4xs4LeB+wJv+LvvLxDCbTX65i
         OyDoc4HlAjK2zaZO2Vo/A1GvhMzVljtOVNzv97J9fhXCgesjOTX9XMjL3fIx9/HaMwua
         Li2LO5WkiAAHp10ZA+bBqztXNb2cTzSTvyqzmnbL7LPQGlG6Ei8bZKtzioAUe5gwIsS8
         dNNw==
X-Gm-Message-State: AOJu0YzZX7e8ikl1EQAJTpD+JPwxnFGivfV+VJud7gfDCeXPuothdytX
	l5Ymqs9zA6Mht52Y1bXlD1WsRF89OeWFqJQyjEypc0Zpa/w281jR
X-Google-Smtp-Source: AGHT+IFQquVg6J8izEu9FKfABdecORagWrz5/1Obmd+nyIOcsnk+4ac+/n39W+rw7uhygsSXNBvA8Q==
X-Received: by 2002:a05:6512:3904:b0:510:1818:4f14 with SMTP id a4-20020a056512390400b0051018184f14mr386701lfu.30.1706612811740;
        Tue, 30 Jan 2024 03:06:51 -0800 (PST)
Received: from pc636 (host-90-233-198-33.mobileonline.telia.com. [90.233.198.33])
        by smtp.gmail.com with ESMTPSA id u25-20020a05651220d900b0051119371e7csm233199lfr.120.2024.01.30.03.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:06:51 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 30 Jan 2024 12:06:49 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Andrea Righi <andrea.righi@canonical.com>
Cc: Andrea Righi <andrea.righi@canonical.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <ZbjYSXhIrVyCpRNM@pc636>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd>
 <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>

On Tue, Jan 30, 2024 at 02:17:22AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 30, 2024 at 07:58:18AM +0100, Andrea Righi wrote:
> > Hi Joel and Paul,
> > 
> > comments below.
> > 
> > On Mon, Jan 29, 2024 at 05:16:38PM -0500, Joel Fernandes wrote:
> > > Hi Paul,
> > > 
> > > On 1/29/2024 3:41 PM, Paul E. McKenney wrote:
> > > > On Mon, Jan 29, 2024 at 05:47:39PM +0000, Joel Fernandes wrote:
> > > >> Hi Guys,
> > > >> Something caught my eye in [1] which a colleague pointed me to
> > > >>  - CONFIG_HZ=1000 : 14866.05 bogo ops/s
> > > >>  - CONFIG_HZ=1000+nohz_full : 18505.52 bogo ops/s
> > > >>
> > > >> The test in concern is:
> > > >> stress-ng --matrix $(getconf _NPROCESSORS_ONLN) --timeout 5m --metrics-brief
> > > >>
> > > >> which is a CPU intensive test.
> > > >>
> > > >> Any thoughts on what else can attribute a 30% performance increase
> > > >> versus non-nohz_full ? (Confession: No idea if the baseline is
> > > >> nohz_idle or no nohz at all). If it is 30%, I may want to evaluate
> > > >> nohz_full on some of our limited-CPU devices :)
> > > > 
> > > > The usual questions.  ;-)
> > > > 
> > > > Is this repeatable?  Is it under the same conditions of temperature,
> > > > load, and so on?  Was it running on bare metal or on a guest OS?  If on a
> > > > guest OS, what was the load from other guest OSes on the same hypervisor
> > > > or on the hypervisor itself?
> > 
> > That was the result of a quick test, so I expect it has some fuzzyness
> > in there.
> > 
> > It's an average of 10 runs, it was bare metal (my laptop, 8 cores 11th
> > Gen Intel(R) Core(TM) i7-1195G7 @ 2.90GHz), *but* I wanted to run the
> > test with the default Ubuntu settings, that means having "power mode:
> > balanced" enabled. I don't know exactly what it's doing (I'll check how
> > it works in details), I think it's using intel p-states IIRC.
> > 
> > Also, the system was not completely isolated (my email client was
> > running) but the system was mostly idle in general.
> > 
> > I was already planning to repeat the tests in a more "isolated"
> > environment and add details to the bug tracker.
> > 
> > > > 
> > > > The bug report ad "CONFIG_HZ=250 : 17415.60 bogo ops/s", which makes
> > > > me wonder if someone enabled some heavy debug that is greatly
> > > > increasing the overhead of the scheduling-clock interrupt.
> > > > 
> > > > Now, if that was the case, I would expect the 250HZ number to have
> > > > three-quarters of the improvement of the nohz_full number compared
> > > > to the 1000HZ number:
> > > >> 17415.60-14866.05=2549.55
> > > > 18505.52-14866.05=3639.47
> > > > 
> > > > 2549.55/3639.47=0.70
> > > 
> > > I wonder if the difference here could possibly also be because of CPU idle
> > > governor. It may behave differently at differently clock rates so perhaps has
> > > different overhead.
> > 
> > Could be, but, again, the balanced power mode could play a major role
> > here.
> > 
> > > 
> > > I have added trying nohz full to my list as well to evaluate. FWIW, when we
> > > moved from 250HZ to 1000HZ, it actually improved power because the CPUidle
> > > governor could put the CPUs in deeper idle states more quickly!
> > 
> > Interesting, another benefit to add to my proposal. :)
> > 
> > > 
> > > > OK, 0.70 is not *that* far off of 0.75.  So what debugging does that
> > > > test have enabled?  Also, if you use tracing (or whatever) to measure
> > > > the typical duration of the scheduling-clock interrupt and related things
> > > > like softirq handlers, does it fit with these numbers?  Such a measurment
> > > > would look at how long it took to get back into userspace.
> 
> Just to emphasize...
> 
> The above calculations show that your measurements are close to what you
> would expect if scheduling-clock interrupts took longer than one would
> expect.  Here "scheduling-clock interrupts" includes softirq processing
> (timers, networking, RCU, ...)  that piggybacks on each such interrupt.
> 
> Although softirq makes the most sense given the amount of time that must
> be consumed, for the most part softirq work is conserved.  which suggests
> that you should also at the rest of the system to check whether the
> reported speedup is instead due to this work simply being moved to some
> other CPU.
> 
> But maybe the fat softirqs are due to some debugging option that Ubuntu
> enabled.  In which case checking up on the actual duration (perhaps
> using some form of tracing) would provide useful information.  ;-)
> 
As a first step i would have a look at perf figures what is going on
during a test run. For such purpose the "perf" tool can be used. As a
basic step it can be run in a "top" mode:

perf top -a -g -e cycles:k 

Sorry for the noise :)

--
Uladzislau Rezki
