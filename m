Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D82D542F;
	Thu, 12 Jun 2025 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749762244; cv=none; b=lDJMRrzFOE+rYzqRtn88bZaimCWT9rVJTe3VgESe4u3TRKr+lmKS5M7wa1N5DtGSKJdUViyougSuR8iONVNmY5aQ35ZzAHfpVLcoJFYyA0OURSUD5AJqHd99rPp5HZSz9OYVcdLfAX6zg4Nx7jqtnTPN5c5ezxt352m6xgIrEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749762244; c=relaxed/simple;
	bh=uxw0BzC6rSUkvYOPCduhWRzUs8evqOeD/6uKWDwf9N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTaez3EAAjsXfYl4zvzqMoeIlpl75ISyZHXwc6Al7o1xvwi+TOZcz/1UaD6dfJoSHXiMo+koYJ8aMwU8j1dsYGr0TIwKkvs/3vrCddEPVrB73Vj6AcZsge/xM+G8W15/GGv2llJbL7Z2otlANNll4YUvwAbDC+CPLbUSk6ZQ/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGHnCqs6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGHnCqs6"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d38d562a55so175240485a.2;
        Thu, 12 Jun 2025 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749762232; x=1750367032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f+tMjCkjbUzohT4TxXm1SW9/KPVce/N5IYy77LJaDpA=;
        b=UGHnCqs67nzs6EUxye6hYPia+sMVTevcBq1z9s1kRe3HSx6WqYVY7hssWLZff69ws8
         Gf6ecyQ9UFrlp7Y1WrIy3caWLTPHNOU0b7W9hFxLsnhOCBKrymD1f2zNKwvRbOjNQz8+
         kC7ViCbx/4ZTtyk9HRlrgt5D9pAdizHtT+UXjQWvr4aJi6+KfTHZuetLCCp8HclzP/Tw
         CIjZhmTevRpnT52UfMXljE9WAOy2PxFMJ56OGmzQ77JgBnX2RCSF/60LLmJ1C5dOl8k/
         nl9YzbV3Rg+iJFLjVz+yAFAULV4nX58fzG0zFKXOuhIbOtoJ/53vYKxsLS1K3YPxbq13
         LySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749762232; x=1750367032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+tMjCkjbUzohT4TxXm1SW9/KPVce/N5IYy77LJaDpA=;
        b=RAr+JqAQ2GGB7YOflZV55XuIEXxbT5LO0W51qyvx/MCQ1clRX097VeU1kQ6jRrU2rI
         LmmIFS2FduP9fa6UQFG/H2q2hMnPEkVk5yM0Neq0rp+Y7xnik9GTDm3+hik759X8u5yI
         xBLaelXEZX1vPrbxPfVIdjFK0WjTurdkv7MLM2eNV+4WhILnvek1yPBj6umBWXoYfQ86
         gA121BKVl1PRu8yOcFo5wqSy0Kw2feYzfuMx7ycj09vZ5KMmRoBzCe4Grvt/Rpo6QsLo
         +Ir5WxLEQjfFiZs0HU8tH3E1M0rA88UiULHZu+9+J/kjgevlmkmr4qglCaZgan74EzlA
         /ARQ==
X-Forwarded-Encrypted: i=1; AJvYcCUggWjjUE0sK22SNt348KoUaZUwCIsM5Hpg8ihEhYpA8YGLH4J7dwiPhZ6dp+nxjLKOwz8bfPFLqX49P6s=@vger.kernel.org, AJvYcCV9uUMZAgRt3XbGzFsQdnbGn9GHuaWJknc/PQeeJUtsa45lMvQPoohNGB+J41DF3B2wszkP@vger.kernel.org
X-Gm-Message-State: AOJu0YwzeeeJ/0ORAbs7Z8phFEvLiP1mZzhRWanZZPBVk9DpCdft58Ax
	tAt6HwV7pfg0BQrEiSayv2eCbAA3IAyd70bpnRzt9aRSIm62BSYDHMTD
X-Gm-Gg: ASbGncuHl4l5M3llVy+OdHiyxlcC+TSb7jss/Pp7mKbOFXuLpTnwxqBiqfsnMJG1xoI
	h3bprN0V9AJ0EM7NmAYoSw0naysBIBlJq7O1Uhu/K9yB1kic/eR3hXBOIZgCiOPPHoZGEME+gkP
	3da5BdgdJ7vPK88SRuPL701zaETlDzuJmirRzpg80a1rAxZgVhjQbZaCkvKyB5uHVxsBAOFaW6O
	dcBa3yWlKrMqFCBH93CNsFNdAtWo2orEeDREWka4b1gxSoVMs2OXdgdwA9kMg4i+bRYYBG200p3
	v99E78ibc5u02ozojT6NvbjJBHC9B0VcI2J8CeIu0Qwqx5F07yJqEZzUAO1wni18Svh6SD2rCVv
	iwxzR8xjQ/2XPsc545kLaZKJgYzRoA4tZeUBJ8c9YFRtMHPrRr3fwsfab8UqJ2lY=
X-Google-Smtp-Source: AGHT+IFolrY2XYIaZa7ikgmYxOmDdryzYTeYwHsD38jeKuJnAw4BWBlK7pjsqLfBynGfp+ifYTZw0Q==
X-Received: by 2002:a05:620a:3197:b0:7ce:bde3:583c with SMTP id af79cd13be357-7d3bc3da75emr120204085a.17.1749762231654;
        Thu, 12 Jun 2025 14:03:51 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dc9b58sm84412785a.13.2025.06.12.14.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 14:03:50 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 696CD1200043;
	Thu, 12 Jun 2025 17:03:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 12 Jun 2025 17:03:50 -0400
X-ME-Sender: <xms:tkBLaGTsWur07fHq1sxnsnGFv02n-2IUXXH1iNTxrUdekB0N0tyu0A>
    <xme:tkBLaLyaPmXp4IFo8snZ99qJuY_78HO_1-Km9DcpcdaTKxdJ9kjYuneLeEbPdjUaf
    sx6O88aQuFSw85E9w>
X-ME-Received: <xmr:tkBLaD0iXf_5vmcrGZh1_oxy2mUugqInWqTl6LuErUhCOZNq5H4MfGYFJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduiedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgeehleevffdujeffgedvlefghffhleek
    ieeifeegveetjedvgeevueffieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomh
    dprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvgdprhgtphhtthhopehprghu
    lhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnh
    hvihguihgrrdgtohhmpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghs
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhiesrghmugdrtghomh
    dprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tkBLaCDOiSIRccOGGCp0myBSuGDa6BBy05NU61fKNOYrUnW6CV8RQg>
    <xmx:tkBLaPhHoYXx0z0HMxBtCxTq0SNSBkTsjtyth_9mNZSUspDem8Ucxg>
    <xmx:tkBLaOoQ27WEXu-M4BrYcVSdYz13hjZ9lobRGqLpdFy2KKa750gkbA>
    <xmx:tkBLaCgBzjWPbrdtRlTt_E3Gu8G37nxKLgwCn44e37TpeNxEAgEgKw>
    <xmx:tkBLaOQ6UceaePJiUu5DW7pSgqPL-ANKORNAZHDZwf292QrIUjv1Lbgn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 17:03:49 -0400 (EDT)
Date: Thu, 12 Jun 2025 14:03:48 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun@fixme.name>, "Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/3] rcu: Return early if callback is not specified
Message-ID: <aEtAtLu6IIv_0QHs@tardis.local>
References: <20250610173450.107293-1-urezki@gmail.com>
 <4bc63cf3-29a4-4a64-be65-30f7bd55e31c@nvidia.com>
 <0caf7054-140e-4b6c-abd4-2ec2ebe79b2c@app.fastmail.com>
 <aEsSZINUrRvy1g4F@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEsSZINUrRvy1g4F@pc636>

On Thu, Jun 12, 2025 at 07:46:12PM +0200, Uladzislau Rezki wrote:
> On Thu, Jun 12, 2025 at 10:30:38AM -0700, Boqun Feng wrote:
> > 
> > 
> > On Tue, Jun 10, 2025, at 12:33 PM, Joel Fernandes wrote:
> > > On 6/10/2025 1:34 PM, Uladzislau Rezki (Sony) wrote:
> > >> Currently the call_rcu() API does not check whether a callback
> > >> pointer is NULL. If NULL is passed, rcu_core() will try to invoke
> > >> it, resulting in NULL pointer dereference and a kernel crash.
> > >> 
> > >> To prevent this and improve debuggability, this patch adds a check
> > >> for NULL and emits a kernel stack trace to help identify a faulty
> > >> caller.
> > >> 
> > >> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >
> > > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > >
> > 
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > 
> Thank you for review, Boqun!
> 
> > > I will add this first one (only this one since we're discussing the others) to a
> > > new rcu/fixes-for-6.16 branch, but let me know if any objections.
> > >
> > 
> > Not sure it´s urgent enough given the current evidence.
> > 
> Let me clarify it a bit. My point is that, we get a kernel crash in a
> subsystem we are responsible for, i.e. no matter if there are faulty
> users of it(third party applications), the point is users can crash it.
> 

Fair enough.

> The kernel robot reports it and it is already a strong indication that
> the subsystem is not hardened against invalid inputs:
> 
> "BUG: unable to handle kernel NULL pointer dereference in rcu_core (3)"
> 
> so this in the rcu_core() which is part of RCU.
> 
> But, anyway Joel should decide. I shared my opinion :)
> 

Of course, my point is that the urgency is not high enough so we have to
put it in rcu/fixes, but it's a fix, and if Joel had the time to do
it, feel free. Joel's decision.

Regards,
Boqun

> --
> Uladzislau Rezki
