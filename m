Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E02837F;
	Thu, 26 Sep 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370432; cv=none; b=BDndG+vJ/DBE/N+qhQO+P5VtAEufSPE7iGRLbtOJu8tFdn+LyxTItLdK3PKlcVukGz7qqH+60bHn2HfV5Aneh4Crjuk1Plongq1sRs2Bz7oYffI64lII0HGEm7EC+naAobOI/8wN8cqgE6/F+ajRC2tz7l9pwVjFcxtToMQIDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370432; c=relaxed/simple;
	bh=5iYZJMNJaZKXw4tCr+pREI1qBLnsU3gIXs++lWmTl20=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHOAVM/f4JHGvMvAuEb+hKL/0Mq7ybYMz9H9jwBoiRKSlAGRkp0W8VmmiC3El0Axr91QJjXZN2KhmIiIOFvSJk3/qGYQ5ua8JrMhckoMpInJRT2L5uAt7vbvNdCon6Wv05iW7StgKeWmG/FWnwFNqlCd14kiOJl1KJJcWdlEXp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCFgfG5J; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCFgfG5J"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53655b9bbcdso1562642e87.2;
        Thu, 26 Sep 2024 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727370429; x=1727975229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSW8LKXMvjgCAP+LleMXU69ztDlOwlRznFCMfPkydaM=;
        b=CCFgfG5J9smb0SgswtDV+CGNJjUG52RrI6VynBVw2KBs9VwIPtS0LC1bLmpt0OXvlX
         7lWVT3h7XYC6LhGO3ejV1bXlM/C33UB/MM1h+xo6xGInP42ayglV7S3YY4fMsrorzsvE
         vPLx3tb3CUCsI44s6E3N7JM5nhGhqT+4GYWU+VQPMum7FvKN2gLY7+xHS7jdLPQXPfyU
         pZep3vIAvgLAYgYCNra+QGZSlY7U5F5vfvGmJFqkUbo/+ez1AkeU1irxC/tSp53ntX+p
         o4baIhlm9/XgpI7SIcX2nZ9UN7/TomAI9M/PQgEjBjVdDWGrvQ27B0bNHVA6Pgz/RmAV
         Ct5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727370429; x=1727975229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSW8LKXMvjgCAP+LleMXU69ztDlOwlRznFCMfPkydaM=;
        b=oCs+x6eILvIjAdEUs66wqxIl/7BdyS+T4V4JBSzSdAglE0xRIiKuoT3n339L5TbNMd
         r9/orZvvQuc1Ma+/pcVTnBqPTgO5pN2Mmtxm6w3msgAoyRpz2++/1ZDMjir96LlQQ30A
         3SJylZkSd1pGmQ5g3Z5cBWOgxeUUUxKs5+erh1Jgr1fymI8/4fI+OdzFbrzw0kS89w4l
         KY/eZFvJH3IlwVEeRj9G8M/po6y6sWffm7KnTaly2rP7RfeeNU+wdAurwRL9c4rpP5En
         rceQsqDFbBhISLrsw6WMwjEfE+nKOwg74vO+LNQJB1FTyhKiHnLXJZkoKJnjNRAok9YP
         fREQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn3CQaQFNfWrHSHk3BefsRnja1+wS9ipZctIHi/wMx28/O0ZVlR9GRIun2xdxTc8I6MCX4@vger.kernel.org, AJvYcCVyAdJy0sO3Dj9Ey3Rbytg1WOZs/2A+RZl1srkVsLZx3kAdhFqjyqLcx16GXARDevjfm1buJWkjNZ7USd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRacCymXUVkjjGzFTju4B/X/JglGtkkuyvzxNH7DL1wxa6WYEw
	xb6sJU1lyB0ZfvODEMYeexJeSk+72zwHwagcz0WNLoFrFY3QFOKp
X-Google-Smtp-Source: AGHT+IEnamfg1YzMrkN+Y0xDuc7LwiVl+tEE9IblD4TwlLvLyB7usjEJR2zCtegZ59qGLt8W+vQrqw==
X-Received: by 2002:a05:6512:3093:b0:533:45a1:88fc with SMTP id 2adb3069b0e04-5389fc478c4mr260702e87.30.1727370428211;
        Thu, 26 Sep 2024 10:07:08 -0700 (PDT)
Received: from pc636 (host-90-233-216-205.mobileonline.telia.com. [90.233.216.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd5e365sm13887e87.79.2024.09.26.10.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 10:07:06 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 26 Sep 2024 19:07:03 +0200
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
Message-ID: <ZvWUt2oyXRsvJRNc@pc636>
References: <8d6c5d10-5750-4472-858c-eadc105453be@suse.cz>
 <CAHk-=wjmu93njmUVqfkAbGKqHaOKFrTmgU2O=UkP3OOmpCjo4Q@mail.gmail.com>
 <CA+KHdyV=0dpJX_v_tcuTQ-_ree-Yb9ch3F_HqfT4YnH8=zyWng@mail.gmail.com>
 <0295538a-4b79-42bf-b0e1-5a905749de1e@suse.cz>
 <ZvWOl1mmBIgi5Vg8@pc636>
 <88ed491f-4ae4-4cfc-9be2-dda3de56813c@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ed491f-4ae4-4cfc-9be2-dda3de56813c@suse.cz>

On Thu, Sep 26, 2024 at 06:46:29PM +0200, Vlastimil Babka wrote:
> On 9/26/24 18:40, Uladzislau Rezki wrote:
> > On Thu, Sep 26, 2024 at 06:35:27PM +0200, Vlastimil Babka wrote:
> >> On 9/18/24 16:40, Uladzislau Rezki wrote:
> >> >>
> >> > Thank you for valuable feedback! Indeed it is hard to follow, even
> >> > though it works correctly.
> >> > I will add the comment and also break the loop on first queuing as you
> >> > suggested!
> >> > 
> >> > It does not make sense to loop further because following iterations
> >> > are never successful
> >> > thus never overwrite "queued" variable(it never reaches the
> >> > queue_rcu_work() call).
> >> > 
> >> > <snip>
> >> >          bool queued = false;
> >> >          ...
> >> >          for (i = 0; i < KFREE_N_BATCHES; i++) {
> >> >                 if (need_offload_krc(krcp)) {
> >> >                          queued = queue_rcu_work(system_wq, &krwp->rcu_work);
> >> >          ...
> >> >          return queued;
> >> > <snip>
> >> > 
> >> > if we queued, "if(need_offload_krc())" condition is never true anymore.
> >> > 
> >> > Below refactoring makes it clear. I will send the patch to address it.
> >> 
> >> Looks good, AFAICT. Can you send the full patch then? Thanks.
> >> 
> > I will do so. We can send it from RCU-side for rcX, this merge window or
> > you can do it.
> > 
> > What is the best for you?
> 
> Guess I could do via slab tree since the original commit went there too.
> 
Make sense. I will send to you then!

--
Uladzislau Rezki
