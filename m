Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D46A14A4E0;
	Thu, 26 Sep 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368863; cv=none; b=Sk/K3RYe9rkAr7l2hjtCHS36wlZkL90pjtiNfFdDSXxUFRGaFfB4k/H45vnZMV2FoAQvc5oey7yIX9KDhmEZWg0DKZHxekg6SdUPl9XQ9Edbg9rxsuBWQXiisnxsnQLiSaL/zXfqG5qZgSJsXyz8/ia3WIItAZyXn2NHsujeW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368863; c=relaxed/simple;
	bh=lnx2KBLjQ9hEpSvedvjm5EjvnkpIvBZ/kC+D81DVWXw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFRjsYlIiI4iPFArCkaKYxRh041UiE3Ew6lAIsOM7nuAaP/XAjD5b/StMocQqTdEN5lwJLacbEhyZWEw9YETF1Vsaw+hf7+aZZsXAt2Ln3/IKTYdbOrZoKnYpBD5WNLekdYpG6YOSWD5MmG8Rf08YdwqOnwBK9nIBES3Gsvwkpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi3z2+Yv; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi3z2+Yv"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f7528f4658so11662771fa.3;
        Thu, 26 Sep 2024 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727368860; x=1727973660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JU4mphy76HwymguPoEKzi3kj2OGTpmV+ZH2XF2JvXyE=;
        b=Qi3z2+YvhXgTzEW0ZkHd8UyHETTqjS8t4rteacSFcE3yt5jqUZLcS0aX0QQ2acjOJV
         IQJpW91CuAtQ1uKRXTPUsFFy6wkmvojS5b78K4aLi5uRpqWhxZq+C3G1NwNRe+qFjPbH
         YT3ToI7KZ4c9ZXACTP1LdhwcVPzIyt19ZHdsF9dCUl4+o7ZONcZZJWYFSm3h99PHABie
         xHZQd9P8Lh8fi62JX4YtiGkpcPtBJyHCHpgn+7JpE9nfFGQD4m80qg0b6AskBJA05hZ6
         vHPM64TyiwiGDgE+bA6iTIsTGQw+5HNYkMU8ZUEf+SxlauxnSPAth5o9CBmVJT25tA/B
         3yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727368860; x=1727973660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU4mphy76HwymguPoEKzi3kj2OGTpmV+ZH2XF2JvXyE=;
        b=Vf5w0xCOkpR3DLB6OZ3U+PO8DpsuWgiCQPQIkkPtbQSNfuq+IpzN0VaP/+xF6CEkcw
         6yXdx/KmP0ceEVy3YX0Mh+JYarr+6saW9tHPz0+wwRNQ8E37RfjQa1Yh61YryOZB7C1I
         FYElou6r0/sPeqc4BYaGqG1odSRxTqW69eW06tRFGAqfUgKl/LVDWiZPjKqT5vRydNHF
         X5RaVr1t7TejbRa02OJBhL9JQ0P7t9ixnHNGOSKCwVZNGceWGKLokok7O1z0ui67ni4W
         y8b1nPZiTGqkKWsW2TpxAN/+/ADgl7ZVes3w+f5aIN+0LA1dg2ARpJAgxCo9Ld076ebD
         kGaA==
X-Forwarded-Encrypted: i=1; AJvYcCV33X9r/KhFffFXIpEvJvoW/1Me659QbGnkympijBJVogsbOFasrA18GEm4A8Kol5vOHSAS@vger.kernel.org, AJvYcCW8C7piscqaAvr9hTvT1NutAOvldi6LV+aITsF5bnbveNxBkVWu+0d05ylTql7a1u2ICbU4x514i3/8yZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14+z6OC+QncrIKNrkuqMoreJoFIS6QOu9575d/KUJnIv9D4yJ
	c+TuynfnbZo4DC6QHSlZLzIXGIrUypzODufSak3H0yoesKMDTip6
X-Google-Smtp-Source: AGHT+IFNMjJtobgVHAE/mIi34OHyZUsl9oqOCVmzQ2Ns4AEr56Ppkzvzlb4OxRDp1AHrcPkuPiJpNA==
X-Received: by 2002:a2e:a58d:0:b0:2ef:2cdb:5055 with SMTP id 38308e7fff4ca-2f9d3e56140mr2340081fa.20.1727368859388;
        Thu, 26 Sep 2024 09:40:59 -0700 (PDT)
Received: from pc636 (host-90-233-216-205.mobileonline.telia.com. [90.233.216.205])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f9d45d7a91sm86511fa.47.2024.09.26.09.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:40:58 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 26 Sep 2024 18:40:55 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Christian Brauner <brauner@kernel.org>, RCU <rcu@vger.kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [GIT PULL] slab updates for 6.11
Message-ID: <ZvWOl1mmBIgi5Vg8@pc636>
References: <8d6c5d10-5750-4472-858c-eadc105453be@suse.cz>
 <CAHk-=wjmu93njmUVqfkAbGKqHaOKFrTmgU2O=UkP3OOmpCjo4Q@mail.gmail.com>
 <CA+KHdyV=0dpJX_v_tcuTQ-_ree-Yb9ch3F_HqfT4YnH8=zyWng@mail.gmail.com>
 <0295538a-4b79-42bf-b0e1-5a905749de1e@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0295538a-4b79-42bf-b0e1-5a905749de1e@suse.cz>

On Thu, Sep 26, 2024 at 06:35:27PM +0200, Vlastimil Babka wrote:
> On 9/18/24 16:40, Uladzislau Rezki wrote:
> >>
> > Thank you for valuable feedback! Indeed it is hard to follow, even
> > though it works correctly.
> > I will add the comment and also break the loop on first queuing as you
> > suggested!
> > 
> > It does not make sense to loop further because following iterations
> > are never successful
> > thus never overwrite "queued" variable(it never reaches the
> > queue_rcu_work() call).
> > 
> > <snip>
> >          bool queued = false;
> >          ...
> >          for (i = 0; i < KFREE_N_BATCHES; i++) {
> >                 if (need_offload_krc(krcp)) {
> >                          queued = queue_rcu_work(system_wq, &krwp->rcu_work);
> >          ...
> >          return queued;
> > <snip>
> > 
> > if we queued, "if(need_offload_krc())" condition is never true anymore.
> > 
> > Below refactoring makes it clear. I will send the patch to address it.
> 
> Looks good, AFAICT. Can you send the full patch then? Thanks.
> 
I will do so. We can send it from RCU-side for rcX, this merge window or
you can do it.

What is the best for you?

--
Uladzislau Rezki
