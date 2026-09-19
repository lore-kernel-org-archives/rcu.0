Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3FE2F690F
	for <rcu@vger.kernel.org>; Sat, 19 Sep 2026 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835931; cv=none; b=iAjnUc9WzseSRd5GiWL42VcqDUJkto8zlsefHjhB+eMnU1Zyyh734iUJ/BkwolAd+PsFMBrOZNl3Tbwn2oLDGEMvn2KigEJ67/bDF1q2v4RSysbNusbd28+fXIZpxN+6YHpF3gM7BpRCO42kWoLMTYvj1Ln9ojewhszBsDWUiOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835931; c=relaxed/simple;
	bh=nBbiCr4fg61dV4D2oGNu2aR4a7biYiZnhkG7Z99V1Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKHMulh782Rz8NrVhMrdXtnvc7/q8pjFxfVW0P++8duQ6XGJDSwU3HL53i5xEHfjkWZmLdvvAf903Krp01gizPLjJuWh7++kpIQ6wR413sxfJy3hxlgys5LKbdPLApaYP/Cf6MBnl51+Ti0F4z51ZoUF91+PtvUB0X436uCDXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GcKiEvX8; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GcKiEvX8"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6aa053900f5so2981546a12.1
        for <rcu@vger.kernel.org>; Sat, 19 Sep 2026 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789835927; x=1790440727; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGWocLshUzVVG8Rydp43t4CQtO4FrerHAEoPSMI/C8I=;
        b=GcKiEvX8WVl2wuGNft9OZSBJ1bPPr04NcUC7U2Vny3m642bX00UPV9ROWvJEyPt03S
         eHTn+sp/Fkaqkw4Le2veTMeQK+TzHzWNjqcFYYEnEmluEVHkEkQ5ZCotsHN/9713+pUq
         omEOaIqq4yN6ubzVZonE9fXTQgWtoWFAwxigI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789835927; x=1790440727;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UGWocLshUzVVG8Rydp43t4CQtO4FrerHAEoPSMI/C8I=;
        b=FhUH+j22h5xXI0PJgDX+K8jDgajAIAbfsHJsyegRZu4ZFO6ISpS221EpZeEZSPzvQ4
         hpxHgZjfT86j7L8DP3CYKV8CY7zwz4xDFRxRN/PtyxPOVKfxaZ4dKom+vK6Vx3edUA6/
         d5NSisvWDNZeGQLcuoqB56mPz4cfGWlDyE+OU1L527+BNgY35ycGXNHg/WMJ8lsQE7Ha
         OkI8on19U3ovO6huIpRRC4+ig7sjgGOOtIacFMVZSaXEaUembEnqZnDK+QiWKRFjDIKJ
         fJFlamq1ED6pOMqbLD/a7EyH6l7/8UUu440IExUxuut1Px1WPU1TyBLnkJwatC9NJ3TD
         rfRQ==
X-Gm-Message-State: AFuF++kNFhrObHKDjhdqMspreSXGTXtQWa0DKIb9orhvii539VeWxtQl
	Jvsxub6K7NcqVa7WzRFkAjlxm8xhiv0/iupY+BXetPuT4JVVtOTRB6d5690B7zOfZzeMpbKQ+zd
	ilo0mO2s=
X-Gm-Gg: AYBFou16JfHPeM7sYGmcEs1I/zK0TcK6Pgjbfk1OtaxYuuP5vrxJ0INJ4ayfuqs7lJr
	vBDVbwyrztQsKR/f1ZbNVajiklrLgNOckla5N4wpBxwI3vkJnn6OkWpARC6B0flwJpsAvIlRyIF
	dC+tVu4YzP0qhtiKd8GCsRRXAyHnwtGboDEa0eYm+CDYJE2Ntg4RRgK+cAuHcNuQ4f2ymWuU0Gj
	okm451GOdncfmPVvna52BgMuT15qW40M7MeeUacrzxaP1TJTNRzeNTzEBpTso46n2Wd8zwrxDIa
	OyvoWhv8puUBk6T0i7iac12d/jIX9tqaCui+J7Ma8k86VyhhOli2Lmr6x3Zwur1c26i1GfgCXyw
	RDBAOrXM18Yj2Qq5ozTxV6KFJzHPcV2/NMhlEyCMDIca9uKs/+71BKmYYP3jkpCXbNPzYIKiEFD
	qtTGZTKOo9fpjb0qypfikNUPjQS1DX8WNlg28TyThlLDXQYssS0vlr+sFIvwijHdzItWFt+W49D
	EnNyizW9umMIZfielIeueas16itGgjetyaUD55RbYKkMJDkrOgT2Qqg9IVq
X-Received: by 2002:a17:907:971d:b0:c26:19de:9acf with SMTP id a640c23a62f3a-c2a15e1fcf7mr499262966b.39.1789835926788;
        Sat, 19 Sep 2026 09:38:46 -0700 (PDT)
Received: from mail-ej2-f20.google.com (mail-ej2-f20.google.com. [74.125.228.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a358868e1sm96673666b.47.2026.09.19.09.38.46
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 09:38:46 -0700 (PDT)
Received: by mail-ej2-f20.google.com with SMTP id a640c23a62f3a-c293c683202so258826966b.3
        for <rcu@vger.kernel.org>; Sat, 19 Sep 2026 09:38:46 -0700 (PDT)
X-Received: by 2002:a17:907:6d0b:b0:c29:2646:fc3c with SMTP id
 a640c23a62f3a-c2a158569e3mr548265666b.15.1789835444190; Sat, 19 Sep 2026
 09:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop> <20260919000056.3132131-1-paulmck@kernel.org>
In-Reply-To: <20260919000056.3132131-1-paulmck@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 19 Sep 2026 09:30:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9knmxXD01=top1DQ9_aqrN2a3kpWRS5DQv6QLwLOztg@mail.gmail.com>
X-Gm-Features: AcwNN1UfxSUGwclkVhiP1abbV-DjzJIO2ybg4zteTUzmnNfVhojty9fZ436aqK4
Message-ID: <CAHk-=wj9knmxXD01=top1DQ9_aqrN2a3kpWRS5DQv6QLwLOztg@mail.gmail.com>
Subject: Re: [PATCH 01/28] hazptr: Implement Hazard Pointers
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng <boqun@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, lkmm@lists.linux.dev, Zqiang <qiang.zhang@linux.dev>, 
	Wang Lian <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, 
	Bradley Morgan <brads@mainlining.org>, Nicholas Piggin <npiggin@gmail.com>, 
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

On Fri, 18 Sept 2026 at 17:01, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Its main benefit over RCU is that it allows fast reclaim of
> HP-protected pointers without needing to wait for a grace period.

So last time I looked at this was some time ago, but the thing I was
missing then seems to still be missing: actual real numbers.

And no, I most *definitely* do not mean the pointless "do this in a tight loop".

That's just garbage. Honestly, when I see those numbers it just makes
me go "I don't want to merge things that even mention this kind of
stupid load". It's worse than irrelevant - it's an actively
misleading.

So I want to see a real load where this is actually visible not a
"loop a billion times on a hot-cache thing that doesn't do anything".

               Linus
