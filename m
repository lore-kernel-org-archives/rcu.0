Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6471B81CC;
	Fri, 27 Sep 2024 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727479272; cv=none; b=pdd1q0OZyzEDhS84fa56f0A7STbNLzEFqIXCTGVL7IkfgF7xhLbGy5SdBOiqkYDevkAsNSLyqc44Inl726ToXUHlDQFvvAJtt0xutRXwZWu0vQ6sPMbnaGEYQEY4vwuWy4mVgjEOZ0NrY0HfOqQXkoH4Ygps/e44k2AKIkizc+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727479272; c=relaxed/simple;
	bh=FEOA2rJOqDQDdAsoe75gRmLT3XIG7BacAiVDnHTKlsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF0SXhHMtIOJMzRTsQhnhp6G/3M+2F6G28+EXGmd7r6nTopON05ziov6c00nZq2m0zJ+iVqaWH/zi0Oq1spxI5xJA0+4jaG1ArKLofeQ3QXKkUpqRLYD1ZO+8jY8ZDyCYdRfhbevzYhIcKPMQLoj/+2VcitMv5Nepv5ggksBoIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/h2/Xav; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/h2/Xav"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45aeed46f5eso11574921cf.3;
        Fri, 27 Sep 2024 16:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727479270; x=1728084070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRWP0NQhRRIkTJAGGN9No6EkCeFNUseCOmrQOI6Inr4=;
        b=X/h2/XavzY451ARFTf4/EQh05Wb7+7lilyAWVQvSAzT2iQX5HCwht5WMjreGu6RQkl
         oPGyU+0tafJMp/iIunYI3ydhtBvbFHakRvQjcIbrAmcewqBsnDrx2N1t4073Kgt9XnUE
         hzI7e5j6QAhlpJAiWNeKSCV6md3d/GMdY5x8O3Ig/rDpapB+iAacWGNiQXJ751A1hnKf
         YhnTQDTKfLRohVCJa5sPIL1GvyWa2r7VKaR3+4gv/6W3iT6QFI84RgF/AVDdZQiKQmLY
         UKZBTAzt5RFcXDekcZfGuvh4voMON5JyWkxCVljOsnzkGLY8wHplXLordQ16aWlecmy/
         L1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727479270; x=1728084070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRWP0NQhRRIkTJAGGN9No6EkCeFNUseCOmrQOI6Inr4=;
        b=MPE+1PxO2NAuPKlo4iFj99oLxZDZ8k1/3aPYIpmXFwUqyEGaZH8SilUT6AzKerxjvS
         7RTq6XT3gJSov3uUo9mQojprY+1OSHWEwalExya0CTG/f21vh8Vgy+t8IhBnzyNnXxa0
         ECOQcIAt3szW1+xJykIHaK4a29yISXUVi/ytPYJygAavW3d22KlXTJHJ7DN8tIONbxTl
         pdkzcyjSfbQP7X/Y3l7I88Xj154nFvEhsHgs+DQH+ndS01I20xnmU/YUo4IKDfvDx7xP
         ElYgrDNbdFCl8bsqXIz0jHCLg+5muAX+vxSzfI6BkxnFgW64YaqvmBdcR3wBC0xEYaIe
         XgQg==
X-Forwarded-Encrypted: i=1; AJvYcCUcETy6maHZB2T0ZhP/Bqt/6VAboX+0R64SFdcNmPV+pGiaAUPt2EWJDY5bCVjn+ExrqWFZhPAnGYQyAIk=@vger.kernel.org, AJvYcCXu7waAeKy5wnVxe5YKcs7yGwPmbbAUcKE8x+rzMQgfnf5m6T6SjowThHbLie75Z+NTaxkV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0GigGF/AjFud1UmdKK1rFLs6OiDDm5mIYPRvzgWS9RV5WTbU
	9MEhYIRfrmYKAJGYJkWqfFTLGgFzH5tD5aavGv+B4iMhzawjEA/i
X-Google-Smtp-Source: AGHT+IFVYWr7YfLP2ZOmoXZeV+ICDbqgORNSo+RKjNe6YotBXK+vAKKnLzTlsohS5VqeARSVg8gozA==
X-Received: by 2002:ac8:5a49:0:b0:458:5191:65c1 with SMTP id d75a77b69052e-45c9f20e2e4mr63920411cf.26.1727479270057;
        Fri, 27 Sep 2024 16:21:10 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f290162sm12661021cf.3.2024.09.27.16.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 16:21:09 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id E1EA01200043;
	Fri, 27 Sep 2024 19:21:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 27 Sep 2024 19:21:08 -0400
X-ME-Sender: <xms:5D33ZpbOAoqWbsQEWv-2ah-lKjQzTxxiAx_96i-apsXeBvlGE10HCQ>
    <xme:5D33ZgbWChfSpGTTSocGO_Rr4Q65sDBkqcjxHRDYqawY4cJD1TVkLXrIQ6YhXNZ1V
    eodm74MS6NnU-I6Lw>
X-ME-Received: <xmr:5D33Zr_czgSae13vz_NG4jWDYfzbfsgvdepqy4sYZ_Ztwi5uCik0-KzzAlhu2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddutddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpedttddugeeuveeghffgueffteffueehkeegtdff
    feehhfejfffhgfefgeegteeghfenucffohhmrghinhepvghffhhitghiohhsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedvledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhr
    tghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpthht
    ohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhr
    ghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughu
X-ME-Proxy: <xmx:5D33ZnoDX035qFKxQ5NqPjWe7tIhXakWcMSeR9X4B80yXSNB5mD-bw>
    <xmx:5D33ZkrbT4sbI90ifwgb8pSgMwmpZ43xW7aaDI8bkL14ZvEDeC00Fw>
    <xmx:5D33ZtR2I-Uj11BrrQ1qZLKmOIKT6mg52MSnXFZ4TimMZOuiIjK7yQ>
    <xmx:5D33Zsqh6UJKV-ZYNMU8Zezt6tsCg8A_z-8ygUJOcF9ZE3uZIDVzjg>
    <xmx:5D33Zt4rvr9Jo2GHF4t6OYBC0jChwiplFVQaxJyrH0yrUA4Patuw1kza>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 19:21:08 -0400 (EDT)
Date: Fri, 27 Sep 2024 16:20:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
 rcu@vger.kernel.org,	linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Message-ID: <Zvc9sg4TCqrmgjkz@boqun-archlinux>
References: <20240927203334.976821-1-mathieu.desnoyers@efficios.com>
 <23882bd6-c0e0-4f6c-9000-b79216194198@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23882bd6-c0e0-4f6c-9000-b79216194198@efficios.com>

On Fri, Sep 27, 2024 at 07:05:53PM -0400, Mathieu Desnoyers wrote:
> On 2024-09-27 22:33, Mathieu Desnoyers wrote:
> [...]
> 
> > ---
> >   include/linux/compiler.h | 62 ++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 62 insertions(+)
> > 
> 
> I'm wondering if this really belongs in compiler.h, or if it's so
> RCU/HP specific that it should be implemented in rcupdate.h ?
> 
> [... ]
> > +static __always_inline
> > +int ptr_eq(const volatile void *a, const volatile void *b)
> 
> And perhaps rename this to rcu_ptr_eq() ?
> 

I think the current place and name is fine, yes RCU is the most
important address dependency user, but there are other users as well.

Regards,
Boqun

> Thanks,
> 
> Mathieu
> 
> > +{
> > +	OPTIMIZER_HIDE_VAR(a);
> > +	OPTIMIZER_HIDE_VAR(b);
> > +	return a == b;
> > +}
> > +
> 
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
