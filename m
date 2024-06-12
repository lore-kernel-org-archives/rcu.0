Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA041C2D;
	Wed, 12 Jun 2024 05:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718169721; cv=none; b=Z0BrEpUP8MXTH2peVm5uAlDQsBSpW+gWOoIm7ZjzdYMu5yI1TXSgm2t18hgzFtNIdLOZoHcBi0XKSfgGNREiDIaPDbJacuU9eOvjvk79m6xyN/wXK+Dw0GEH7nIcmPAqK0FlxIgGvp2FWnwKNLiJayaF27OKuwSySM4pGgbo1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718169721; c=relaxed/simple;
	bh=8SGOda8tYPcw0wzFjbPUAUG2mv09WHxbpDwu0cNWIFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ml2166lDugBjm/EL2ajqF0bxCUR2z61W15m7gJFNOv8KD1CcvnlVdPH9GtwnHxYe0PAanA9BVZmHtIhOG5UcYjMDAUKZmPQHRRE9bO1OZJ66GuklIttK7HCRUMU6RpIYowMXRhWnQa/b9A862ZyRgyFtdFN9WqSMKPTfHbsfuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJzKow9T; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJzKow9T"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48c4a821d76so1015381137.2;
        Tue, 11 Jun 2024 22:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718169719; x=1718774519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjEwJgRoG92FC9Vw5huQBkdZy2fxtlgBnuBKB/008U0=;
        b=XJzKow9TKqUCW9TmDa5rKNQxTtDpSNeVcSt6QWMhIkRzm/zQ90nWoZa/w5xw6RVmwz
         2p3ABsv2oCNQkIP//1cvDC2mNCeXFwbcE6bv1C6WQBVHFvLCLQNp2xgV4RC6lb1vCdk1
         jxqBpojj3DIlgYbIQnc/lxTv9Ut/YSiRL36duXOYAA0cdwZ5bEDdQ/yfVr+0GrB6VNo4
         N+/BllgyLD2CLVeluJddcdMY907nAyxB52dzUAOy6JcGvsjLOqPmlqYrrhaF1oYPKp3M
         2Scnug70Gr/XJFCOf/WOp8wET8Xce27/AhfpHhH9522MB5oYaIbaguI8mszk8kAAi6te
         KjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718169719; x=1718774519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjEwJgRoG92FC9Vw5huQBkdZy2fxtlgBnuBKB/008U0=;
        b=D/BO4D1LGzsQDFSHkCbYQXHf1c5cFGyDCvpz7TBSf0cMheYHsUselzsrOCbvHk4hP+
         /ewKgDIHbJ18ebTLDB3BvTeYahnwIj7zTIwx1pFftAg0wYI58GoRzHpPny+uyh3bzSLq
         CAfXRWmofFBuAv1mlf0OAAJYI474o4edw0zJ1jfRs4vEutaYFfOoAAXEtiDnUY3wVSPg
         nu+UtP+HDu5S2jevb9hFPArEdMIVVVa+pcR7i08lDUyivosvxoIz8d3piSxFBSEDXg3Q
         wHV3cRiSqfTDDtuR3XkMLZc1UXNl9EWwljyn7XaEKqaqJKM40R53hIoJ98tB88/0Kk3f
         Z1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJzdieaVpq9Aj3C8/Tfm8stcTPcxwr37x3qhfwtnmXG9R9j5H+5ODzFwc2I+tWgXsbCK/wd9CT7BD6uIGhLzREwnlQSiFwcrrUnZN4
X-Gm-Message-State: AOJu0YxaSKl4eg5JtCqr+jjzUUz3vbeILHzFyJJnePFlE6ztSy2yU0KT
	VhTdlwV4T5xK3ZXfTpLC+Sk4DswdO3RfrjkRMEptFKsTOaw/yLx6
X-Google-Smtp-Source: AGHT+IFDvF86CuK3Kg24+xx5dBk2/UDjJk+sWB47rTKVHiKT+QQs97LesjLepl9XawzJSkfEe8TcLw==
X-Received: by 2002:a67:b641:0:b0:48c:4d59:6295 with SMTP id ada2fe7eead31-48d91de3080mr974801137.19.1718169719138;
        Tue, 11 Jun 2024 22:21:59 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-797a2b7f956sm186654985a.6.2024.06.11.22.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 22:21:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 2893D1200043;
	Wed, 12 Jun 2024 01:21:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 01:21:58 -0400
X-ME-Sender: <xms:djBpZjepV48rA8difPCs5QQIvsblVI7GqyooEM7GVBuLcH16ihDHFQ>
    <xme:djBpZpOSBMMS1yv7MEuoR35VjkeF488ge73Jx5kJkC22K4G57GbHOnZgXqssf0WWB
    LlpdvgelIy0Snt0_w>
X-ME-Received: <xmr:djBpZsjShrWrBibnu9O0Z5xGTsFQUDKh4aBvdzdl2xYg3fHO5SgeEPA-Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:djBpZk_bCnEb_qh7jne4GYOzjhOCd-swKy33lBc1UEW6ZbCk2qtrLA>
    <xmx:djBpZvsewM13dmMZPARhg3iAt4WCJZFI0JeqkrOkJGXIIwT-aoIvfg>
    <xmx:djBpZjFP7fB-7itURqGUpDkD_-jG_qeF881mb10M5DIalgYd3C57Fw>
    <xmx:djBpZmNP-rupTPcCkq3RtbEC-2Lk_76CXmNW5bi2IfkV9fzr5J-n7g>
    <xmx:djBpZgOM2_4tEuUKI0CjzbgPmeiKi1FhZDowT24t05GD5MTbv4HMNHp5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 01:21:57 -0400 (EDT)
Date: Tue, 11 Jun 2024 22:21:56 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/6] Grace-period memory-barrier adjustments for v6.11
Message-ID: <ZmkwdFhXK2SsVWa4@Boquns-Mac-mini.home>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>

On Tue, Jun 04, 2024 at 03:26:46PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series removes redundant memory barriers from the grace-period
> code paths:
> 
> 1.	Remove full ordering on second EQS snapshot, courtesy of Frederic
> 	Weisbecker.
> 
> 2.	Remove superfluous full memory barrier upon first EQS snapshot,
> 	courtesy of Frederic Weisbecker.
> 
> 3.	rcu/exp: Remove superfluous full memory barrier upon first EQS
> 	snapshot, courtesy of Frederic Weisbecker.
> 
> 4.	Remove full memory barrier on boot time eqs sanity check,
> 	courtesy of Frederic Weisbecker.
> 
> 5.	Remove full memory barrier on RCU stall printout, courtesy of
> 	Frederic Weisbecker.
> 
> 6.	rcu/exp: Remove redundant full memory barrier at the end of GP,
> 	courtesy of Frederic Weisbecker.
> 

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst |    6 +--
>  b/kernel/rcu/tree.c                                                     |    2 -
>  b/kernel/rcu/tree_exp.h                                                 |    8 +++-
>  b/kernel/rcu/tree_stall.h                                               |    4 +-
>  kernel/rcu/tree.c                                                       |   19 +++-------
>  kernel/rcu/tree_exp.h                                                   |    8 +++-
>  6 files changed, 26 insertions(+), 21 deletions(-)
> 
