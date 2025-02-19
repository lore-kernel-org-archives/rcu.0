Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84D1F30DE;
	Wed, 19 Feb 2025 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978300; cv=none; b=E0VuXm5S/BvNR3IaMEAChBBBESBUkAQNH5e+qojQNwZL4/TrbP0i4bNjwaQxJTqpsJnFt4/8ykHWWw5Z9hAMZxP1htSvWribYbpsepV/Bxo7KXV0yOLhDwishiMgIrIyKkI9qY9SG4dX4WSt40sauhfEhgnAkin+9UGUM7V3plg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978300; c=relaxed/simple;
	bh=WDgCjJRFu3cpvwh9ZFp7xL9yScHvsR4ZVRiy8MDpaIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1hPg+NIY72aB2A0x1QZUO2zzU/GRmySPY4lbG3AuE95X6sxt+AM40gP5/cvOzp/2SGNoVjhrlmAPQeGgPv+PcJ6zefTqOZfccB/q3U5iMAQc1HP1KfbbW0xOjU0QzBGx9CTkf1pJuBYbBMeHkBkGNqWQxzfPkIS/BNXMPo3aRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CK3NdJZg; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK3NdJZg"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c08b14baa9so393427585a.3;
        Wed, 19 Feb 2025 07:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739978297; x=1740583097; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/igI2+izRn+gsaDV378C2NyZbM7zS9w3M82iDKpds/4=;
        b=CK3NdJZgpEaWbWPDdFKZyRptSjXZEJ0s+00oYmoZgbLd+q2nRWmp8GH8KHOPrTkVtn
         t5fZ7RhIUDfPDJ35EGOF1QKICIfO4PpWli4f6W0/XWZDiVivcpF7/ROHX2wLqPqSnSXL
         edIHlSl4QdYgb9ApTNn3ZnvyG9DYoHsF47Y6lu90GW8YzlLLjWgewBw6D4a4JasnOL+y
         Z0/CKuFYUo2rGseLvXjxzyM74LSoZyPFaZ33I0bfEKwpQzB/ZQH5w2UZVDixc6znrc6n
         IftAouM8cJQxvWuOR0VPdWTr9zHncLsjsQOvfdaU8/0QtzYMQRn3ENlrmjLclCOu8RB0
         1vDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739978297; x=1740583097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/igI2+izRn+gsaDV378C2NyZbM7zS9w3M82iDKpds/4=;
        b=sZMAEOpBpx1/cQWiObs8Q1tNkztb+5SCkbFPWAtqAQbYPF0JH47IZpqBXBfnsN3c4U
         pZr9uygH7dIICNP4Ur5lRHy0ZhOkjp1w0ya1nTqmM7Zy6OtD0ydG0UT9wi6KSo/EYQmi
         ud3nI+wJ0sknbqC7ObtKX2lSlfrsErqxDfJ9GEeseibp63WVrkgNmIhUyMKnQXd5ytwF
         0lwYAVqqv7XfRZ1MPhDU2b6owyz9Bm0VZzl8IK+MrPq6msMzpRsSE8bN4dj0DlREPjrx
         S8pxdNWin6QXEpCxHoSUEz7YQBN5yfNyEKIRhuUJTlx9fogl9ecPU0rDYlpL7nrrqWtW
         sp7A==
X-Forwarded-Encrypted: i=1; AJvYcCU3e6FPSnezRKuhPk6gR6Q6ml7cS1LLql6+liBF4vE4otbBBWbMQSViBgPtlyzMqUIoxIXbN+TceYXOwHw=@vger.kernel.org, AJvYcCWwxXpXVnPz/Xm81nOt3yioKoXDk1An1yRobQ+qEDU7LHDFD2C5TkEleFQ9ciRKUjKD+jsv@vger.kernel.org
X-Gm-Message-State: AOJu0YwKICtlZOfRCyef2w4kHnVPRqceJjcphOy5ViIIFDlMYwLBfrP+
	jCG2J+53LHjML54bBLoIy3A79hk4Wcvm/8uZthbihnY2gu8C1Bbo
X-Gm-Gg: ASbGnctxTUa0atLTJoZQtYJM6ZUsDfs5GDPc6sYhxSGKtQ/cevRYfrps+jPobggoHBd
	cCX4mDJKF1ztkR/vCg9myc8wGI3htXl2CInO8SkWxDuZgbrfRCa0TUzJ4oh+GPukRhiMoHzS0rS
	t71UCMJ/M2HRYjgD+c0V2v3WsTkiaQ/UhWaiOcEGT2eVGnYl72YaeFREWsMa5OOaMO7qBRYWewg
	23bPIdIDk/EYxckPzqYhiY3fd+aneYDnsCW+gw1HoGMO0NaieSc5UWAQeonXoyv8IeKr+y/ponx
	54M9/l3MyIjYyEGhppfRy4omfQK4VGYEsf2+sFflwZG3Lj4vpWAkY9C/jcN8ChZAqoxYtDWkklS
	WVYyR9Q==
X-Google-Smtp-Source: AGHT+IGqwRIiKPq/bF3cv3dC/wJUhUv944r9R3U2SS1OmARTq4CY1eu7K4x8KjKofJxcrSq8PhtdBg==
X-Received: by 2002:a05:620a:3906:b0:7c0:6c5b:d6e5 with SMTP id af79cd13be357-7c08aa75d2cmr2870077385a.54.1739978297408;
        Wed, 19 Feb 2025 07:18:17 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0bde74158sm37958485a.28.2025.02.19.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:18:16 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7ABD31200043;
	Wed, 19 Feb 2025 10:18:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 19 Feb 2025 10:18:16 -0500
X-ME-Sender: <xms:OPa1ZzqTdPftys00Jf4sp1VedihL3pLLhOJgJwrXq_AkQRwjUbGPqA>
    <xme:OPa1Z9rnVmaskD9hdCt8ifPn843H7Y7b6s0-0cA6yvjtRnlMxps9z4G3AohzxBx4D
    TislM97EPGu2qDuBA>
X-ME-Received: <xmr:OPa1ZwPspmdAoWqJbIUvEYnvOsA76fqasURCHqPkt8QPnoxaeHCevTXP-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgeehleevffdujeffgedvlefghffhleek
    ieeifeegveetjedvgeevueffieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgv
    lhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghoqhhunhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:OPa1Z26bxIvbS2yGIRs6d6Y00FcGmQsPCftTH9HmYRMXlAOoxgv7lA>
    <xmx:OPa1Zy7GBhAcfpfTMJd1uokQxVpi_FBHRYMZiMXez7fY0MUhHf1BFg>
    <xmx:OPa1Z-hRPgCxKyxcbvrbGHnWTQhC5Ng1eAH5micJV4EO2IA1ZtviwQ>
    <xmx:OPa1Z07hnDwDqx7Gfr8cParrWBhK4Zar2nTdrwg8xv5Gls5cYRWsJA>
    <xmx:OPa1ZxLP0CEb218F9l_dur6U7BOOyGyfpY1g41LtFlNsluFxfL48XBHa>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:18:15 -0500 (EST)
Date: Wed, 19 Feb 2025 07:18:14 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH] MAINTAINERS: Update Joel's email address
Message-ID: <Z7X2NtrfcYslZ8UU@Mac.home>
References: <20250219125425.1175676-1-joelagnelf@nvidia.com>
 <49abc218-cad3-4913-a729-82e5aa78a0cd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49abc218-cad3-4913-a729-82e5aa78a0cd@paulmck-laptop>

On Wed, Feb 19, 2025 at 05:23:08AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 19, 2025 at 07:54:24AM -0500, Joel Fernandes wrote:
> > Update MAINTAINERS file to reflect changes to Joel's email address for
> > upstream work.
> > 
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> For RCU and LKMM:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 

Queued in rcu, thanks! I guess it's fine for this in v6.16? Or Joel, you
prefer to v6.15?

Regards,
Boqun

> > ---
> >  MAINTAINERS | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6ff7ba6cc270..97aba6b60158 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1608,7 +1608,7 @@ M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >  M:	Arve Hjønnevåg <arve@android.com>
> >  M:	Todd Kjos <tkjos@android.com>
> >  M:	Martijn Coenen <maco@android.com>
> > -M:	Joel Fernandes <joel@joelfernandes.org>
> > +M:	Joel Fernandes <joelagnelf@nvidia.com>
> >  M:	Christian Brauner <christian@brauner.io>
> >  M:	Carlos Llamas <cmllamas@google.com>
> >  M:	Suren Baghdasaryan <surenb@google.com>
> > @@ -13296,7 +13296,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
> >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> >  R:	Akira Yokosawa <akiyks@gmail.com>
> >  R:	Daniel Lustig <dlustig@nvidia.com>
> > -R:	Joel Fernandes <joel@joelfernandes.org>
> > +R:	Joel Fernandes <joelagnelf@nvidia.com>
> >  L:	linux-kernel@vger.kernel.org
> >  L:	linux-arch@vger.kernel.org
> >  L:	lkmm@lists.linux.dev
> > @@ -19671,7 +19671,7 @@ READ-COPY UPDATE (RCU)
> >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> >  M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
> >  M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
> > -M:	Joel Fernandes <joel@joelfernandes.org>
> > +M:	Joel Fernandes <joelagnelf@nvidia.com>
> >  M:	Josh Triplett <josh@joshtriplett.org>
> >  M:	Boqun Feng <boqun.feng@gmail.com>
> >  M:	Uladzislau Rezki <urezki@gmail.com>
> > -- 
> > 2.34.1
> > 
