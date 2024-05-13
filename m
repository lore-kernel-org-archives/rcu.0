Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197251AACA;
	Mon, 13 May 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619683; cv=none; b=hUho9EvCERpSKNIOwMd8F2CR6fKvLZLq1R3+um7B+G9LbTPyoIAcwJzO7xFRgMSyrCm997T3ktluE9z6I9S93Nii8PAIVXwiI+Zbn20TKG3cVfs4lE09cxNE6zvEdqGMsC6L6gwcJBnY6Z5J7VTQlvW38rprP2O5VUBy0Bp+TlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619683; c=relaxed/simple;
	bh=XsZtZuRiNpuWeI9mzQ+m0y+LVUyl0guK9RaBIDr+LAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdS9wDhC3bQGEPh30wVw4nv3hFpQqYL+QFLDs3SHQ2UdMAjdRqBenXTYj3ANkAcPOzoDAjioOEiYdhWtkBHkX5W7Vf9wrMAvikadt5FbxxCSWT8/JLy6gLj44FiHyifWCQ6OMp3TTz+Pk4dsMX5i/R5Erv0UmS1uRJZoqf21Bng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buCcPj+i; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buCcPj+i"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-792ce7a2025so59058485a.0;
        Mon, 13 May 2024 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715619681; x=1716224481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYkKLBBqb+wHJGa0p+AL05B0+Hq45S8piw7EzZCu8QM=;
        b=buCcPj+idDixLB7H4eQfabmBqxq/iiuPruMfJCMwOLNCDNjarDuFmXjswR31BuvVYs
         JQRBDrHHvmv10+x5t5YrnGWExsHakldE+yDihG2zItI5MGhYb/i/AA4YE/AiD4apzGLR
         WFmwrrodOJwKeVhglkZWEVdooG5drmU2cub5IVvDbJRVK7aKwg7i9rqFz855T5ckGB6I
         KdNZdYg9bSOIrRg3uTPrHbnemENckEEp2ZSyzkNNlMUAONKUSbJ/MrvUDS9kVivWEZUm
         kEBiMlXMf3LQLjHihjB340RV0D/V2Mw+ZUgSqPvJOR80tuL8W2YTJmXSl5vCRJESDYC0
         htmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619681; x=1716224481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYkKLBBqb+wHJGa0p+AL05B0+Hq45S8piw7EzZCu8QM=;
        b=QBlvNTXiN092SV4FxsJSXhZK6Z+0168fOfBwrxxS4+FhTavzOj1LKHv4Kgg45ADUHW
         kgs63+/+1ml5Z1Xl9G3s67lKGllraLDcffN1iSSvkq+OKYpxwpV0pMwnU1DlmML0Vdy8
         Z0ODp2HRqc7vy7w+pXd3M1aPdFfnJ4MogMYyIN5LSX3NRiCvEMff5xeI9i7hfnzU4/XI
         Qz/KxN4KqS4QaCDNuoy9XrmbEr2dUGFGBeVoe3RkB1/azCmd+bB7Adf6iF7tKVYJ20s/
         zcZGge1jUVleDFCgg5bmUR47s4lr99uuUNJyNygUu89fqNb7unFKC1dQeB8K84J1fkLq
         bMIg==
X-Forwarded-Encrypted: i=1; AJvYcCVpZdRmCNKw9Wb1UHDrdfiNSojPNXXxDMRmRN5lDaxvgZqQ0F/Znnsd4lFH8BrO8ZhHLRGlbRtah8bRUkE7CWDS1bh1jRdH0cnxs5GxyX9o63JLCs+YaXHjQwdbsPed9kub
X-Gm-Message-State: AOJu0YzChGHzz9ok4oK54uGR0E+wIn0M9WSgcnBpi6+ohJox9endGtCO
	gmQM7vRXYh3Cb25qAk3j86z8GMwDfqXYGtvVi37jhBRssYykbL6a
X-Google-Smtp-Source: AGHT+IFqtDw1zpak/yUs+kLR9yR+fmMLsjFVR4D5N6mYic0jZHbPNMj+gRyZFdubSlhDkrx0JFqG+Q==
X-Received: by 2002:a05:620a:3859:b0:792:bffb:ab78 with SMTP id af79cd13be357-792c7574a69mr1035529185a.1.1715619676026;
        Mon, 13 May 2024 10:01:16 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27fa7csm472341485a.40.2024.05.13.10.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:01:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 07D0A1200069;
	Mon, 13 May 2024 13:01:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 13 May 2024 13:01:15 -0400
X-ME-Sender: <xms:WkdCZs1Ru97HrtJrKvJQb9sLD_gaR8K76ecG_b_I_ESCiuwEgFB8gw>
    <xme:WkdCZnEeMpjqJEGhrjvrmieIKqfh9hnHt0OaVrRBPtHNlyPsfmeFijw-JKzj2IGrZ
    i0QrHfqezuiy1sBig>
X-ME-Received: <xmr:WkdCZk7UPNr_qUbn-HYHh_VdM19ujL4z8_bjqn9q_xwUel-UHr4DfuRaDG_MTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepteegudejjeduheevkeetteeffefhffehtefguefgteffkeeiteeitddu
    hefgfffgnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgv
X-ME-Proxy: <xmx:WkdCZl3lbzNexuk-m-CV_jrP5kAbLZ0Mcu-JIB7W6L1s5Yypm19iCA>
    <xmx:WkdCZvH6tcJ7paQwpZiLXeXNXAWMejAsE1txT_g0PR9XDmBlJGP5vg>
    <xmx:WkdCZu_6AjwzYMuJMxWqdbruzqyAxYpawa1RhrTMMJjTgRzPSeQNbA>
    <xmx:WkdCZkkjqUP4PdpHxy-9hmmPGTH0HskqqSTmAA8vnR5EuEQNVB4yHQ>
    <xmx:W0dCZvFotKIbCVLuQDVNPSU8yFQ7Jci5L6v-WF1DWIOos7fvVC29wmMj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 13:01:14 -0400 (EDT)
Date: Mon, 13 May 2024 10:01:05 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Nikita Kiryushin <kiryushin@ancud.ru>, linke li <lilinke99@qq.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [GIT PULL] RCU changes for v6.10
Message-ID: <ZkJHUYbrztpfG-BP@boqun-archlinux>
References: <20240510183049.312477-1-urezki@gmail.com>
 <CAHk-=wh=HgEeyKVKGXTKiLdhvs-5t9pFxUkK6ED+zsby=quBdA@mail.gmail.com>
 <e35bf672-88d9-4a00-8237-99298392e55f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35bf672-88d9-4a00-8237-99298392e55f@paulmck-laptop>

On Mon, May 13, 2024 at 09:46:45AM -0700, Paul E. McKenney wrote:
> On Mon, May 13, 2024 at 09:38:11AM -0700, Linus Torvalds wrote:
> > [ I should have reacted to this earlier, but I just put all the "for
> > 6.10" pull requests in the queue without looking closer ]
> > 
> > On Fri, 10 May 2024 at 11:30, Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
> > >
> > > Please pull the latest RCU git tree from:
> > >
> > > https://github.com/urezki/linux.git tags/rcu.next.v6.10
> > 
> > Hmm. I don't have your pgp key to check, but I do see that it's in the
> > kernel.org repo of pgp keys so I know where to get it.
> > 
> > HOWEVER - importantly - I also don't find any handoff emails from Paul
> > or Boqun giving a heads up that I should expect pull requests from
> > others.
> > 
> > Put another way: I really want to see proper heads-up and "yes, this
> > was all intentional, nothing odd going on" when seeing pull requests
> > from new people to core areas.
> 
> My bad, and apologies!
> 

Apologies on my end as well, I should have done this or asked Paul to
do.

Regards,
Boqun

> Yes, this is intentional, nothing odd is going on, and Uladzislau's pull
> request is legitimate.
> 
> 							Thanx, Paul
