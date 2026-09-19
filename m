Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608BF2D7D3A
	for <rcu@vger.kernel.org>; Sat, 19 Sep 2026 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789837229; cv=none; b=WHxpdKakjSUH2zznFQZxymqHFWqdYkS9Q+c/wGftThZma1thHjpLPIUeV9JroqEL3NS2FtxrlIz9mUR3YGQ3ujhRcHPv4qXinT7kzriC8IFM6bYO+H9LoICtV3BmI8IpfbhEc4/X3DCZv+1V2Y/Ixrv3Ya35d8UYbhnPlV+2+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789837229; c=relaxed/simple;
	bh=u36MjiEqXs39fNOYa7M2eitiO4tZva/VUMm3woA92yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0bIyfI4BtRK/1B31XqYvFrbaBBRzivoes4nsKIGsqJ9dQNBbIF75biiL6BJl9s8DUGOygUihic7RDkb9pi6hU7kJxBjM+UX+WzxdjlXkex2nQzIdQAigxHWOdh/tiAK1G8gyAPejWsPGWIzVVp4gfGFNIUTg3az6GGEfUbVQOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P05V/NZQ; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P05V/NZQ"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98dfb8002so2487462a12.2
        for <rcu@vger.kernel.org>; Sat, 19 Sep 2026 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789837224; x=1790442024; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4EVCCJGMVi/Jgl5olIITsEJ4O030sdS93t+4GDKvrY=;
        b=P05V/NZQorlOyxPIo0ZnzfUGNSgUOHDhE+JPEEZwJpsq7nN7/ttXTlbVH+39GAihr+
         zS3KayARUCnozKb2rbDiE5cO7h/UOBDJaVDlRJGiPOvz0CTQ7esmc7Uq3gSqIiegwEZm
         IqoCA7j1saD78pR3W975Yz+1moQ8M7DGVreoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789837224; x=1790442024;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R4EVCCJGMVi/Jgl5olIITsEJ4O030sdS93t+4GDKvrY=;
        b=RGg+WIyRnz8/L+Xu1x3I1CKd5QbU4gi8hyB/g6oHdvhCm1wdS88gk0V+K0hzK6uRoi
         2RFKIDxgawxKCDoSWnmYm/12aN1J/aZVTMO6S+PKCk0xlp6lKZuWAfpxB/FhODeRQSyd
         q+iAzXej08FJKCx8hRO/F7pgROTRex8znC3FIlUM34KkyE76B98gPrJgRPFNNQsiikCc
         xedZRSLiaxWcIDUutkusygXwc3On0nCbuSZ+rS2pLHUQyNZl97F6C7v5esXyKV/wBBQ6
         In2Klm/N4Lwiq1EphlZoaZAJw/+wJN6eXcrCfMtbKMHc2aG3hplIubgpR5pGcY+RtfKa
         1rwQ==
X-Forwarded-Encrypted: i=1; AKwUvByUF5pf2fgFDLzkR3QkMlLC3eQI4NHh1Ybyw6pTXyH24V+f++I6vYLX1PYUcQYnNIJien8=@vger.kernel.org
X-Gm-Message-State: AFuF++mNCctL9+KlQPU46CLsADa+VZgW8yKNNEaz+R2OiuGYFiGQ1npP
	YMYIeAIS8P7KFXtQ5S36r/et6Hq1XkUaO0lHN0dvaEKPcmSQzpqB060vBQOgQ6X/Bh0UH9Uor2a
	QggTHvZw=
X-Gm-Gg: AYBFou0/pRoJAa5fioaIopkfrV6nH7g/FRvQ0oKNW3D2NqIrHvPaa4u6pht7hV6NRa3
	2FxMM4AbTWXnLWjLOz4ZCyvp0NJSa1G21nxiKfyy4gsdEgjLh4mX2DmBk4kjoslbHJ3IQGIXpZo
	SMSaEv3nIPL2JgrncLvNvNG4Bk++jVnnfbi8TQ1ok7hazo7rabXKP0AYahuK2gK8e+J9WwBGGgZ
	RWZbT7rLbA3PJZwMoQOpBK0Amugj/EshGsyxolG3hIO/6I5LDL6o4tFIqU6NqkVYjOC6RisJuLt
	NWZZ1kjtySRvxMFZ9Ku2DCx1y191RYAOqRoki73D3ENQ6oGpYToPyJO8TZ9jcWricrxoUtIuFO8
	NkB82rmiWVkLdPZfsq+CiFqMO75r+RQ+2trfblQ+DvWHRA8+U0ckraAePbh9eD8O3Mq+92a6dai
	dsbFMrImj+9DdA6EzXvYVATtfVDR6qjimXfVnaYGaTgd76XI8xZhb7GWk3QewbIgIYnCXRlwUbV
	43sYTEazEoUXl86FExot5vaylUrVYWhBcsabKJcYKgWu8xB
X-Received: by 2002:a05:6402:4394:b0:6a9:ab7f:c8f with SMTP id 4fb4d7f45d1cf-6aa54611e57mr3761575a12.17.1789837224455;
        Sat, 19 Sep 2026 10:00:24 -0700 (PDT)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com. [74.125.228.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67e1a45esm1457466a12.25.2026.09.19.10.00.24
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 10:00:24 -0700 (PDT)
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9adea43b6so2246158a12.0
        for <rcu@vger.kernel.org>; Sat, 19 Sep 2026 10:00:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzcHXqpp65dVnvv9usJavTx30QxuSX1AvW8HCWNdugeD3g+oQrsbrX4gMWU+tb/7hxhLN8=@vger.kernel.org
X-Received: by 2002:a17:907:3f17:b0:c26:1649:47ab with SMTP id
 a640c23a62f3a-c2a15b4bca3mr522411266b.33.1789837224119; Sat, 19 Sep 2026
 10:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-1-paulmck@kernel.org> <CAHk-=wj9knmxXD01=top1DQ9_aqrN2a3kpWRS5DQv6QLwLOztg@mail.gmail.com>
 <6B1FC39D-6EB0-433A-8E49-E5EFC9379AD7@mainlining.org>
In-Reply-To: <6B1FC39D-6EB0-433A-8E49-E5EFC9379AD7@mainlining.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 19 Sep 2026 10:00:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjyniJy-CX1muCrsZp-i-sLGRYeRYEPN7sw9orRZUCwag@mail.gmail.com>
X-Gm-Features: AcwNN1WCbh_CXATf-FMT8x_ZS8yd9pmRtrkzEOhM9i8GXxqTrntEHha57Im_sMA
Message-ID: <CAHk-=wjyniJy-CX1muCrsZp-i-sLGRYeRYEPN7sw9orRZUCwag@mail.gmail.com>
Subject: Re: [PATCH 01/28] hazptr: Implement Hazard Pointers
To: Bradley Morgan <brads@mainlining.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Boqun Feng <boqun@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, lkmm@lists.linux.dev, 
	Zqiang <qiang.zhang@linux.dev>, Wang Lian <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, 
	John Stultz <jstultz@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik <mjguzik@gmail.com>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Sept 2026 at 09:35, Bradley Morgan <brads@mainlining.org> wrote:
>
> I think hazard pointers are good, what test do YOU suggest we do here?

I want to see a single real-world example of "look, this speeds this
real load up by 10%, and the kernel code was actually cleaned up in
the process because hazard pointers are great".

Not a microbenchmark that tests just the hazard pointers themselves,
but a real kernel feature that has been converted to hazard pointers,
and in the process actually shows improvement.

The ONLY reason for hazard pointers to ever be merged is if they
actually buy us something real.

So I want to see that 'real" thing.

I want to see how easy/hard it is to actually convert a real current
user, and I want to see how it actually results in measurable
improvements in performance.

Something *core*. Something that everybody uses. Because I'm not in
the least interested in a new subtle feature that interacts with the
scheduler and is only used for some random driver or (to pick the only
example I have ever seen) AppArmor.

Now, obviously, the thing that would impress me is something like the
dcache. If *that* can be converted, and it shows real improvements on
some real benchmark, then I'm sold.

Now, I don't really expect that kind of major test-case, but I do
expect *something* meaningful. Not a driver. Not a test module. Real
code.

IOW: "Show me the money".

Because the kernel is *not* some kind of acadmic project. Never has been.

I simply don't want to merge something that is touted as an
alterantive to RCU - which we obviously depend on very very heavily -
without something *major* that actually uses it and shows the
real-world advantages.

The discussion about hazard pointers in the kernel has been around for
a few years by now. If there isn't some real core feature that was
converted to show that, then I think that's already a failure
indication.

I'm hoping that those patches and numbers already exist, and I just
haven't seen them.

                  Linus
