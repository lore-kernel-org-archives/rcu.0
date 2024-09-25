Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC277107;
	Wed, 25 Sep 2024 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261201; cv=none; b=J09W2pDR8CKocLG3f0SWcQlX4mHBGQnAgb1CYiox0hSOs8f36GjehCK3+PPYk4LJSvoEW/mNMKUNdSZyWsWgdxmwsQqIRzNoRHrOCwkEAnl7pegrSYhK9Rg2T9ltBZKW4PrxYGdLxqyzvp1WtkGvkZalUP0VdhwYNLNPjp39YoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261201; c=relaxed/simple;
	bh=uu/PXwiT3eXsRa1cBT+MzQ24JypnbUQpiBpLXUDF0d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIoHIOVYA7Vf1IYTNIDsPBVSbWaCis+ZDFsrKkiMBOwWFOT3i/Pps0lk1M3R2a1r+2Nv+TJhocnsYMGn7m2srAUuQyzJxaYesIC967NOlfbS83sH/2jMbFXr6W2HZaMlKUf09aG803ScS52IQgrKwMm3hCuJprANuiUWztIIC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKa5c3Wv; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKa5c3Wv"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a99e4417c3so573263085a.1;
        Wed, 25 Sep 2024 03:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727261199; x=1727865999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aNL2DkbqIFQCOqqQozrXxRXJzMB2AW4PJqi08QSnaw=;
        b=jKa5c3Wv4yP8JVvFaQAkT68zMF/7is191QtwSv9v1EpToGBz+uC4yx8vmePBG2l7rI
         Zx55iJtEJuy9DkF6Dtf517ANeEmpeC33d76wClknyj9WEHUgdJixrN0rlKrjsIIjgX03
         2Su2iSrSksmGWYtHdk/bk+Lye8qnmydsFWjdKKbK61FCO/p6WHNaHFrIFrt/IivuabHb
         8twBqQN0kbXAMs9DAXBMiYbYZEPIykEUgFVRVR1A55izz22N6CSDzPvyv+rDzCY9ntTB
         497990Z0YYiBooM4qZaHrPNlQsGK9JpFZqU7sLh+BGwB/hEmM8HFutt0Ld5UKA8uUzUa
         rUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727261199; x=1727865999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aNL2DkbqIFQCOqqQozrXxRXJzMB2AW4PJqi08QSnaw=;
        b=rfxgGQCttCiTQhn/lYhLidG0FhwPzfRN5c2WPDWp7hgQoFjLZKeRcgdqGwQkHXbo/+
         DXUhocsQF6xxkIuOR1ISW6v4JT4noXh9/w2MFdwg7Z5+pYGJZd39ODrDpdOw+/4ujU66
         6cyXA7yXVT7Uqnz7MvtYO77vxBXHBiNyvXSMRK0EoWCIros4jlg8kqtScKygxYZlbY65
         ZHllY9N8AbXe3tTx6EAmn+BF5KJ+tS74ENnldwp0W/X2zIVZaNsLBImurelx6kWM/sI1
         n58yhoJW9x4hAGyBkm16HtGW645CBbRrBkB6Foh95uLbGIV4cJOFrZ80Xg3Yg08DSuQH
         62oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9RMaxaXI+mQ8knpjYBeOVZ2thUTGWJLDFWmTspCiuDe4XJAFr2m/ThOqCFwytvd9T/Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/sYN+yuLKgiIx2aW4sO72YF45abmJ0yUZ09AJWpsU/2xSf+W
	naDjo2AapcR2221I3Q3HSDayBHvEvvjj6mox/3nKRGf8YuSK8pAl
X-Google-Smtp-Source: AGHT+IFvHuGGdp6zrYogUOKGpCVDO+pYTLfd+cXdAs25Wrk14yTLJgeGQxPFJrC9SIR0gcCZRTm9PA==
X-Received: by 2002:a05:620a:3199:b0:7a9:bf31:dbc7 with SMTP id af79cd13be357-7ace7461d21mr347540485a.53.1727261198621;
        Wed, 25 Sep 2024 03:46:38 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde62b3d0sm158399585a.134.2024.09.25.03.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:46:37 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0FF831200069;
	Wed, 25 Sep 2024 06:46:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 25 Sep 2024 06:46:37 -0400
X-ME-Sender: <xms:DOrzZjJSGMuMjwT-CxfQOIMmOIVDZyrLcSf_UkXRaVhTZ39XtyDyUA>
    <xme:DOrzZnIHQr2tj5kWc8meY7wB6NkH_Q-dqQJJ3cU5F4mcQooxEKxt0_c-0tOEjjpjB
    UKDW-G1Ma2l5zWINw>
X-ME-Received: <xmr:DOrzZrvvRZjLgKFaJfT4u9c6EV6wKQrSYzKv5rv1yt0cB7LQWcfYLVvZl3D0-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghsrdhosggvrhhhrghushgvrheshh
    hurgifvghitghlohhuugdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhr
    tghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepph
    gruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdr
    ohhrgh
X-ME-Proxy: <xmx:DOrzZsaAcBqNHeASds4eEcgDk_lQ5GM87IQGyL-x5ZCX8D8mNzdTtg>
    <xmx:DOrzZqZ8ZPzkMZfcOkW23uyahf2VuQO16bYMOT03jY6vKQBGQcDygg>
    <xmx:DOrzZgDTtBxTuAMxP71zmYf5zTpIV7o66qzJDiEtE-2XtOZLZw8SWQ>
    <xmx:DOrzZoZoLaVSxlF9wFcEhoILwPTqmYEmR2EHKb_lU5WDGLRW6pzlEg>
    <xmx:DerzZuqxdrjChdezibvqGC_ASUpO23azOPWlRhtKkP9c3eTw1SIKz54b>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Sep 2024 06:46:36 -0400 (EDT)
Date: Wed, 25 Sep 2024 03:45:54 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
	lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
Message-ID: <ZvPp4taB9uu__oSQ@boqun-archlinux>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
 <55975a55-302f-4c45-bfcc-192a8a1242e9@huaweicloud.com>
 <ZvPfmAp_2mDkI3ss@boqun-archlinux>
 <f5aeeeda-c725-422a-9481-4795bd3ade0f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5aeeeda-c725-422a-9481-4795bd3ade0f@huaweicloud.com>

On Wed, Sep 25, 2024 at 12:11:52PM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 9/25/2024 um 12:02 PM schrieb Boqun Feng:
> > Hi Jonas,
> > 
> > Of
> > course, if we are really worried about compilers being too "smart"
> 
> Ah, I see you know me better and better...
> 
> > we can always do the comparison in asm code, then compilers don't know
> > anything of the equality between 'ptr' and 'head - head_offset'.
> Yes, but then a simple compiler barrier between the comparison and returning
> ptr would also do the trick, right? And maybe easier on the eyes.
> 

The thing about putting a compiler barrier is that it will prevent all
compiler reorderings, and some of the reordering may contribute to
better codegen. (I know in this case, we have a smp_mb(), but still
compilers can move unrelated code upto the second load for optimization
purpose). Asm comparison is cheaper in this way. But TBH, compilers
should provide a way to compare pointer values without using the result
for pointer equality proof, if "convert to unsigned long" doesn't work,
some other ways should work.

Regards,
Boqun

> 
> Have fun,
>    jonas
> 
