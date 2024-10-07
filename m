Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D51D47B0;
	Mon,  7 Oct 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308934; cv=none; b=iBYOBZO/1tAmxSrNUjqX5IUQazl0g+e+IWOTqK0EeldRh9QqTJHfRsEuomg7NE7iofec8RnG7+tpATMtCryszqXodLPHDJnwBD3AyxtXnYnlJIGiFMLQLE0hceaf1N00RFQkNfc+T5FXPJsUz7MzpQtl9zj6rZSq8z849NGUEVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308934; c=relaxed/simple;
	bh=HqvDmsEwt3nBhi9RmWBkqnjY7cwdcYMS/zw0M0PgAxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yvlx9kk7/Z0nesfrbpKqhjIgYuD6deZzSR3+kuvuUhPlA0qy1cNuTfOPezbo94Ps2ICMA+A9alEiUhbWwuUlqOX0AOdU9QbaG4ah7owFIuPaTcG1w2w+uA3dnmQavPtyHJ9x3ZdXMh5Qsf/oR2IZ3diEoTar9yFeJ9XaHjPBc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgpMNS6r; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgpMNS6r"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45aeef3ce92so31714471cf.2;
        Mon, 07 Oct 2024 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728308931; x=1728913731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5zlc/854P3mwwD/0En7ZUUQ9UADgcI2OWzxIEzuKD0=;
        b=mgpMNS6rlBys3uXDsAhuXV4H5+dCl9HyjgFdlxjYl4oQb3hCWvLiLxNswnJ0HS2929
         Klrt400Goo93kqnHk3pl5Ba+rOO/O8ysz45/Qb4czw5CA+LgfPJJ9vFBRlmXCfEfVndt
         yn9qcGcSgafE7//5270qFCJSqjQmeA4PmLUjzpNobwinRlBJCyPkW0dezeMjUSg6Jz36
         mtL7V3akmtf5rh6AD53jKdQMheNbBNH/oiqwX/jVJJgnVN7+3m29JuGKptj9qEMNSYCJ
         sEZnubS7RqAXqfLYqMHKM/CS+oFbcQlLDa/EeZ+yn+YllNxu+fofSCtr04dTWmQP/Jfk
         IsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728308931; x=1728913731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5zlc/854P3mwwD/0En7ZUUQ9UADgcI2OWzxIEzuKD0=;
        b=nYB8MBd9Ba7mnoOXmHxtJ9e8gYEJw537fYvpvMVHErNnDvnUT5gQemKej78vY3FAXd
         93cP/eqkMSs1nKkN2WN0/KLrv4sJ/CPy9wgyceC57mLZ3HSjsKo5+lOU5+4YEFDiMq/6
         n5O4c304vJH+cWqLMyrvr6wDDUTj9VHr/aOgaAdumGUTBwuM/sSmTTwTq9s6ONyd1sbc
         Cr/uVgu0Re4uN+ETrEpxv0v0yMiAt3AD4qlAV0RUTQINfoDhgaZDT3RcE+YAKkAiGMot
         Ps4lmgOvs99nRXyvomTKf80G9EaoJWa7KES8Ygs1GYU+Lvx2x8Rb6dQvS0iWGQ1ZqvrB
         2ZFw==
X-Forwarded-Encrypted: i=1; AJvYcCVUSZHL1je41+VOZSlR+H4pv55VXiW6vEfR2ZgLqw36zIuxakuoUQKVNtNLj+jnjfpMefNl/hmie6WRvjU=@vger.kernel.org, AJvYcCW2zmLwWv0lhKqbI9u/UI608sEGHRuFTLOjsobJlMODK+oh6SqcvzuesdaulJ4X2C+RU7IJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKpZPrJlytWqubccsMBk24GwmbmwzTyRNdeCNlYgoxFupYHBW
	jckPGUb1YSiX68rGL6jI0yPFY0V6oltqn2Ffvrx8F2hb6RF1pOF9
X-Google-Smtp-Source: AGHT+IF6VdfvkU2hzrMRUahm5soqFN17kLE0fZGLWYpM4oiAxmIcoVTIgYNseUzL9676we7a+dYQNw==
X-Received: by 2002:a05:622a:1301:b0:456:4655:34e6 with SMTP id d75a77b69052e-45d9ba4f77bmr168237951cf.23.1728308931437;
        Mon, 07 Oct 2024 06:48:51 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74fabffsm26429431cf.28.2024.10.07.06.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:48:51 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1B80D120006E;
	Mon,  7 Oct 2024 09:48:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 07 Oct 2024 09:48:50 -0400
X-ME-Sender: <xms:wuYDZ7UYRZs4syIMayCC4UeoyecbczN_y4XKIb4ZRMcTyh52I1dcwA>
    <xme:wuYDZzk_cDWjpna8tU_w-MPeiJpvGEeugb6PCSaMvLXe4KZ3EB0xBrJxc0yDuOcA8
    GUzCCGINyqKILGZBg>
X-ME-Received: <xmr:wuYDZ3Z5hEefZ-aIGwro7A7D-q8RXUP3yKeUuMDFzNq7d4Qy7DV8qHvnmck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhsse
    gvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidq
    fhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepghhrvghgkh
    hhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghighgvrghs
    hieslhhinhhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:wuYDZ2UnMwoOCDKgZnLYpfSR5H6O4tctjffSG198sGEnRoE-tBEYJw>
    <xmx:wuYDZ1lIjHCxJEvA2EG0eXc6-78kYmdqFdi1xg6xTcyGf91VcOOUYQ>
    <xmx:wuYDZzdgrVXdeKaQmDUBrjU9oyc4dY3z4ZwoLgx3AcacIyfCca7Zdg>
    <xmx:wuYDZ_HylBZwSZ0kvnqzeJjYPxJ_idC6jVlPYz43bu7sMdwn3TJPqw>
    <xmx:wuYDZ3nDjGx3in1J9ewoyqi1NWSvLW_n_mhJ2mXAAT_gqL_qWLWvAMbr>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 09:48:49 -0400 (EDT)
Date: Mon, 7 Oct 2024 06:47:31 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,	Will Deacon <will@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,	rcu@vger.kernel.org,
 linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH 3/4] hp: Implement Hazard Pointers
Message-ID: <ZwPmc_CXW15ilRaK@boqun-archlinux>
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
 <20241002010205.1341915-4-mathieu.desnoyers@efficios.com>
 <Zv3kP477pGeOxuu9@boqun-archlinux>
 <bb890ea6-742f-40b7-ad3d-aa28f658fa3d@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb890ea6-742f-40b7-ad3d-aa28f658fa3d@efficios.com>

On Thu, Oct 03, 2024 at 09:30:53AM -0400, Mathieu Desnoyers wrote:
[...]
> > > +	/*
> > > +	 * Use RCU dereference without lockdep checks, because
> > > +	 * lockdep is not aware of HP guarantees.
> > > +	 */
> > > +	addr2 = rcu_access_pointer(*addr_p);	/* Load A */
> > 
> > Why rcu_access_pointer() instead of READ_ONCE()? Because you want to
> > mark the head of address dependency?
> 
> Yes, the intent here is to mark the address dependency and provide
> a publication guarantee similar to RCU pairing rcu_assign_pointer
> and rcu_dereference. Do you see any reason why READ_ONCE() would
> suffice here ?

READ_ONCE() also provides address dependencies. See the "DEPENDENCY
RELATIONS: data, addr, and ctrl" section in
tools/memory-model/Documentation/explanantion.txt.

Regards,
Boqun

> 
> Thanks,
> 
> Mathieu
> 
