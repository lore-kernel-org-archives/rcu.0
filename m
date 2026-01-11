Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727E33BBD2
	for <rcu@vger.kernel.org>; Sun, 11 Jan 2026 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133664; cv=none; b=Q8auzzBASDW0ZQM8GGRGmgZMVV4VqFYf+seBWcOmw9ICCGFgN8cwln2I90qssdO73H7hp6qj2ggKSAj92zrISw1MrcFPXIJNK4h+mPww7tmxx7JTmsIRn9+WD1IVL6NQdBcqHv4fB1/0ASVRrudz+Wo8TsLgADFbJktnYkk/5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133664; c=relaxed/simple;
	bh=ZnR5vF4E9nEmXqv3bakYdN6FLj9OJVaDBTrS5Szj8jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRPfTwZjH+jHdJcYDV2Y+H+s7+HRj5lTmZNEBGRys7EHmK98orgfa69FymYynbkHXtmrLhATlb9qLQXHv3Ptx0kAopSq4nqBGtVZl5FQc5LeJmNrdnXCCnyZBX8XpwyQ8eF8h7HyjlbC1gZmDA3mecZPOktEhOG5wLcmsn9ryrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTQC3rzj; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTQC3rzj"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c15e8b2f1aso577224285a.0
        for <rcu@vger.kernel.org>; Sun, 11 Jan 2026 04:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768133660; x=1768738460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMiRBB4kfESeEJDiUTJbKAXtQIG/adYdh8cr4kB+408=;
        b=dTQC3rzjMX5/rlV6TD291LUhfAR48PQ+Zh644fsj8ZG0/QuM8h2v+z+l5au7PIFKwZ
         sRAI4jiEOIa21GGZPy0fikZZeHkVNmiU1UCVHWGJWtZQhLYexxiO0bPRNJFf1y85RhXc
         RgSvkz1wphFJfgODuEiwQzI2P4LHf73vEjzozxB0i+Kpn0dYIA9C7Dgd1LRJJOA6m2/u
         fTYpyOmMP84Ums3dt2r2/1kxxHcq//jkGaV1FY8ner+d95s6MakdOqX/BOT5Os3JU9Dx
         mKeEL1k9iRHrcDUIjV8gcCO/q+rOOYeZ+jiL+KTLRZw6OTTu/7DABI4KUIw1HCQnCHBs
         f5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768133660; x=1768738460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QMiRBB4kfESeEJDiUTJbKAXtQIG/adYdh8cr4kB+408=;
        b=jQ0iDCzeMm5f7m7JaxisaoNMBqM9qc/hpOzIK6P0rGZWtH2xqWdOK2vDt68olyx4tY
         COc2wa9n9yEMCILW3ACIzl4UK88wnPv2HyommjKzLabJK4FdtWCXAqEBNgy54q3XYppv
         5Fhu/2F/xQbPfbfSMpK/ttZQ+XZh53u0z1248ZBEG/vAvQMovJDL8oxaewVo36O4Npys
         ZgJuw8xj/8nt6Icm8Rfdp0W61cqLncw+5iYVS0j1kPBBRrIB0naUuw5iIJ/cQX9+djQg
         s1CalO1Ksybr7Ijd+uv5+FD13AoHmb0thAnuX9u1CDZ5SyGK8Ep0UBJ4o+pw4OE8X/b4
         LuLA==
X-Forwarded-Encrypted: i=1; AJvYcCXNHQGB/0cKxdDXGXsKZxdXH4/2T0nac4bBd2JE4Y4mD80ElCiUTGcRyQOPBY7xvmoPITM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKQNcxsDes3+BQ9sfwOprRf3HSozj14gnrewm8C1J7QC5+VJQ
	Pxo1F5QMyNlJkffgKYBe8SaS+1/d2yRbRKX2+hcslU9FlFBU/Iy06/CO
X-Gm-Gg: AY/fxX5qAcleR6e/2+o2FhG4kdv5+9btJsLmnpsWcnl+4gOGyw6b93Tv6V9dJ4nOBEX
	6kh1RETl9a3pAaj55hDRDw3LfgSvr7i2FTFEBgYP8985s7eyIPghiGzcQ3eZ7h56qJGW3eaWfBj
	hWVtPHv1K9o3ippSqreUpibCmKpb0hUybqgUGXDg3M9ct1voV4hjiwzDfED/urvi1p8g870BcAN
	2fdqgm9fSMpW72GlqVsTMiOGhdLxfG09vwWSxqUbgCCwFq8BQvGJNYhKQ15XZ9uqDCcQem2u+YR
	K7/sv1XhLZ7Q7gx+mn+G/9Rm+5hXt9MO+h0kr855Q4aYmiwkSXUxwMiUzaDFulqaoUnNGUvzQ0R
	ZKJEqvJZc6oVJFD61Cnq1GWwhG6ey4MJIPjElK56W6TS8Ud/tVj3PaZO58sLOubdCrhZgtLv+vd
	36D/Dpej2EdUd8KlRGrn1td3FOauXxjh6rkIK3+WvyWww7M/vyhxW2pk75ARtbdGujLgNfrNLaJ
	awCThaOW6zWic0=
X-Google-Smtp-Source: AGHT+IE0JkqAhpiXTcPm5o5wV2KUk6YnBL4ZEscybHPIOv1jvprvmO9lHuqxxVrUtHkxwXIktJIN1w==
X-Received: by 2002:a05:620a:19a3:b0:8b2:eb3b:fb3a with SMTP id af79cd13be357-8c3893b2bb4mr2165005785a.35.1768133660107;
        Sun, 11 Jan 2026 04:14:20 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6441sm1307964085a.7.2026.01.11.04.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 04:14:19 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0B2B5F40068;
	Sun, 11 Jan 2026 07:14:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 11 Jan 2026 07:14:19 -0500
X-ME-Sender: <xms:GpRjaWac2laebonezoh-YYz1i_WDxnucXKPtg0524lKyCOMabVtzdg>
    <xme:GpRjae-aU7kJ8N7aTCdCxbO0DqwnjraUkxAvGT9jwZOt76wWlFaVPPIY7EU8Iw8Rq
    n_fkduPGSwNdFrQWY4Ho9nnbAILL2PpmXXmme-EjNp_aGNzhkifNx0>
X-ME-Received: <xmr:GpRjaag5cTBEcnKw0CNa-JxrmkUHZ7ndbtnAH3svPsGrK2Ude4ibevzl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudegheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprhgtphhtthhope
    hfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlrghgnhgv
    lhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrghdprhgtphhtthhopehurhgv
    iihkihesghhmrghilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmih
    hsrdhorhhg
X-ME-Proxy: <xmx:GpRjaZi6aBDQiSvPXisxAZytNtj_qyzGn1yQ2vtw4uaI3ST8XmFgoQ>
    <xmx:G5RjaY4eWF5lmDWjdqUNuAfG9f0BMhtXr1Kborhy0oWmLqG04yj1Sg>
    <xmx:G5RjaTTiRneKXPhDbYH7RflUb34DnPMt3H_FviVYsZdfJSuw5nNasQ>
    <xmx:G5Rjaf9FWOjV70PaRTJrNIsY6oNe1PNxlpamIO17fim2L9VJoyx8wQ>
    <xmx:G5RjacplxSHeSM6qtiad6Qda3YLIjM1IYkA6JwwS34uM1QR3gnjzM-hc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 07:14:18 -0500 (EST)
Date: Sun, 11 Jan 2026 20:14:16 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Paul E McKenney <paulmck@kernel.org>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next 3/8] rcu/nocb: Remove unnecessary WakeOvfIsDeferred
 wake path
Message-ID: <aWOUGC7RnAh6EhDX@tardis-2.local>
References: <aWDZNnIckOHZDolF@tardis-2.local>
 <09954A1D-CB7A-43C6-B30C-4E24731E1FC2@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09954A1D-CB7A-43C6-B30C-4E24731E1FC2@joelfernandes.org>

On Fri, Jan 09, 2026 at 06:20:20AM -0500, Joel Fernandes wrote:
> 
[...]
> >>> 
> >>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> >> 
> >> Ah true! Thanks, so the following hunk needs to be squashed into the patch
> >> then, with the review tag. Boqun, if you want to do that please do, or I can
> >> send it again for the next merge window.
> >> 
> > 
> > We still have time for this merge window, but I see there is still
> > reviewing going on for other patches, maybe you could resend these 3
> > patches once we reach agreement, and then we can decide which merge
> > window. Thoughts?
> 
> Yes, or let us drop these 3 for this merge window and since I am doing the next
> merge window, I will include these after agreement.  I have 3 more patches
> as well in this area coming up.
> 
> So I will re-send all of them together for nocb.
> 
> That will also make it easier for you and Frederic.
> 
> If by chance, we conclude review and agreement in time for this window, you could add them too, for now ok to drop nocb ones.
> 

Given that we still have some ongoing discussion on other nocb patches,
I dropped the 3 nocb patches for now, I think we can still have them if
we finalize next week. Thanks!

Regards,
Boqun
