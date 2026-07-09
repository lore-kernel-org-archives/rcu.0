Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40831BD9D0
	for <rcu@vger.kernel.org>; Thu,  9 Jul 2026 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611393; cv=pass; b=QwCiapgkNEGRz2ckcZpUKoq16wylUX22fIRB93IFsPU+SgiO2+JAwQyAWIdt+vJ+tmGgsgRpmXlW4DeTHN29bX7w+LYmKDwB1x8wdtf1SRi1+7PqNWsPqZWKdeBSCr7cUYkE2j00lfPWcV6O5aOASw3WJ666ph8L+SwIaejJiFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611393; c=relaxed/simple;
	bh=WJBrs4T066GuaDC4D01bHRQo9ktMEwyu0T91k7Uq63A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J++YGvWHtMgPlCNQ7bF5qGcW+i72tViR/Sj/fLPDwCD/fJibOQS52rMGlFUYJqcH8e6NUHsJdsWOPpw5xwmzewUOagUGIS+41fos2cMvarRJ+gnq1Iy5r7L3P+gQEmUXvwoa54+iC71Z8W0JBfmWAAvDU4g1NLip1KUmpeCD6Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX2FdqUS; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX2FdqUS"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6986578d8c0so1616741a12.1
        for <rcu@vger.kernel.org>; Thu, 09 Jul 2026 08:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783611390; cv=none;
        d=google.com; s=arc-20260327;
        b=KSeFt6E4/X4UghEmdOMRaubO/uaUKfB4cCGLH+Y5oQHHwFp1gWpl6L3DngE5U0Wh53
         EZEHeVvtG57pYQ02GqgklAfkho+D3DNNM5/gFRIKuLUk4LBnezmNquFbSNjoQK2872qH
         jIVUhAF+thKk48sdiOPAG8O/8r5fwytvRrDT7FjyTX0m0N7xowvd5R2lRuvoSaMBLlnH
         3/+4mUtAR+8UhKSx+1SLOYxg/Iwfp8WxvAdCMjyWOgc6PvzMbhv1FFpWvLNqwfV2FPmc
         oWjQAodDsJGiAeivwQOgKa+ZZwwYpLgyjVcqwNI/o6jCfASROaE7nVVqNodolZuY+Qbs
         Szhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K3EDMCNVkT8BPRGb277v4lxIK6m6j8prIJdEJ1/EtfM=;
        fh=0a32sBVml1HIh/QBMwCUfYAd9Sn2D0eKAeJB6PxXdAA=;
        b=R45tlVEtV1sMGzhvvfiszYjFs9Xy5sManmh6Y+Z1YTjY/MEhK967M2zvy/6CIPx+hJ
         QLL/NcVR0HlfoZP8IWrE2+RQDKrWp7y2D5+USI0/mQa0140j5OoiojZnbS5ABp+hSffN
         0jKXqIS4tPvUq26gmnMwQM0a+feG+gEu94gsuOFxG9f6PMAwNFpUsmREH7enoIxXlVK8
         9VcB7bbrtVWTWAuWKtSkoHKF0z4TJoTWIEesIKTS4m1G5q1W4zl1N3pKARuln9cHiWdh
         tZrBeT+ni09+l8/3xdcvJsGevQ3Ni7N4+ACZpXxaAHOUM5GhhpJMzLaQtzwqlR5SfcFz
         y7lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783611390; x=1784216190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K3EDMCNVkT8BPRGb277v4lxIK6m6j8prIJdEJ1/EtfM=;
        b=XX2FdqUSSnKcboVj1klVklwkW1I+9ZQjF9wqHr36MhNbCM8Dx4rKVNtCCJBN0l+o6Y
         Wb0gZXzQEYDJRf9h68KkH9VGp9iwqVPGisreu1WSGzRa1j3b92fhMDs5n8giF31DIY7B
         yFtWwWeEMyqrCouEkLl2t9/VJ4BBGpynDdYcPN0Z7Z94BqoPdD4HAvxsV5oR8iZPR5Ug
         SVorFbsY//awaAF/jNiQK6xi/+7EI1/AXBExsXjS/d7LY6gxHgpjW2mxksOvMMtO3xv4
         ssFv8iTEmkxasv57BkxCdN/qMPI0yjlGUHIFqg2FcEIr/akZNObFhKoclNInT2v21RDC
         Ek6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783611390; x=1784216190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K3EDMCNVkT8BPRGb277v4lxIK6m6j8prIJdEJ1/EtfM=;
        b=ZspS0MGdmbVPATKdsJRHFjQH6Mbt/sT2L0E7858CyTGU41leQ3tzyQ4Q4mxoJ8czrW
         6VSAweO9Ph2Wy+YJHhO4dy1oKRROAMIU4WQ7U7bwxbOvCsSG24bwTA7Nzft8gktYCv8B
         TcC0FMVPIkP0z27Jtn2rOrOLqxgPgIq9hRrE+rh0SVs0itFMLElzbS1iauA9qdmwTR8b
         bfHkBeEdreEfqlclx1Y4JHvyZlfpXdvxApqk5JDEvdjt8L58HF0HfK0dxlMmPvaxjGxa
         b53GKJQgTJNh+WBgkUTQpRCtRd03zRKpogT2wyhdaBu7BPpl6/m17V2azySx49TH02qS
         VMEQ==
X-Gm-Message-State: AOJu0Yz1q3cIKsOoER4z1Ii1xGARAWGoiMGiFmuPC06l3DN+n6YskVYp
	p4wW72NOirar4y6jU3v1ux13R2oxqBdWCnt2rsVPIROseBzAA9zxVGcmRAJfCcqwNd+0pfUfDdJ
	FLIcPHQaSsCy2yaLhNAFtTaH1Q5BEhJY=
X-Gm-Gg: AfdE7cnXH8k4r9MkXXXU1Lj50fxUgLotOysZXau/7KWqq9Glu8Ic5LsMixCNW+e9rFX
	dzhS8Yp9xbONK0PPXUqbOp7C0L8olA2u+e955y68mSfBTjmGqRt/H7vg3b5zjh1LlgU65y98ITz
	c6JB0iARPGKUr/YUtq3zimUxujzZvwBiGCcgikd9TnP2cI5oQ82XMgH8fYxVvLOVLljV6fN28PM
	k8MEKGjxjjTNGiApLWjljUOkjZc1p+JtIybhiJ9U8PI8kIW4lpgHIXgUxFkQpRNfpaI6uRCg41T
	kzWa7bctC6YNrucTHUnbUek=
X-Received: by 2002:a17:907:fd15:b0:c12:79aa:8286 with SMTP id
 a640c23a62f3a-c15cdffcde6mr383973766b.21.1783611389879; Thu, 09 Jul 2026
 08:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624132356.516959-1-puranjay@kernel.org> <20260624132356.516959-7-puranjay@kernel.org>
 <ak-pI2CefDoz0D0M@localhost.localdomain>
In-Reply-To: <ak-pI2CefDoz0D0M@localhost.localdomain>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 9 Jul 2026 16:36:16 +0100
X-Gm-Features: AUfX_mwX0hxgcbp5_AnxAmomWbwd-9QdoQQfH0D1zAUoHWqOHyVS9SvP447iYb0
Message-ID: <CANk7y0j=TcK2tYhrmAf9dP0ab=1kzAu=gFasjU76ZFrW5xQ4mA@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] rcu: Enable RCU callbacks to benefit from
 expedited grace periods
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 2:59=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Le Wed, Jun 24, 2026 at 06:23:48AM -0700, Puranjay Mohan a =C3=A9crit :
> > Currently, RCU callbacks only track normal grace-period sequence
> > numbers.  This means callbacks must wait for normal grace periods to
> > complete even when expedited grace periods have already elapsed.
>
> The changelog still misses the reason for this change. I had to read
> the lwn article to understand that this matters under memory pressure
> in order to release objects faster.
>

I will update the commit message in the next version.

Thanks for your review.
