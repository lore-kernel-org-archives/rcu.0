Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36325181;
	Mon, 10 Jun 2024 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717978061; cv=none; b=DH5qOjUi1/TREoG1XWxktSEv9GvRVWDvR/mbmXxkwvo2HmjRfP5vKvPApUJiRgNBUJqTiy+q9398eghMgaUWRxq5cP35B/DQm4Zy+HYwzdpd1xM54YeHtaD6+ogCAB2EnAdnzqD6N8yObEqzHk2G5H1pTGNOKZ1YeErn4whobgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717978061; c=relaxed/simple;
	bh=yNPZXjraPFoWf2B2xycBBK4l0qItoibdC+m6L6zX3Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRl2yUbwestB2ZwulrbQAhtiTpRN33SDEYyfTvsMhj3FUOhn6sJHd99ExG6l2cphhbV7ON3/4pBsicXTqy259nC3KgfBeTbq5Smu6xCNRNq9aqMguvn3k5uEpqqZodAkYMvAtZWf1172mNmjBPZXu7TTMdTb+CQNa+YyQ2GDqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENQi7gMc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENQi7gMc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6559668e1so31975335ad.3;
        Sun, 09 Jun 2024 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717978059; x=1718582859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FynuwZtpDYUJAG2SjU3LA4RZtEXueend7py2Rk3AHE=;
        b=ENQi7gMcxp98K+htKu0DxHRpkJiteoDlGc/7QaTX3vmgk0sSY9p7Xg6YiOkDy80qAX
         +JTQznH4b0sVOMxFZPJ3pl2KVWqklJfoXmFz7sWGlZlKGXDc2in9CkR1Bk1YzKplXAfY
         xWbBOPtI+l0za860ApgYl9IWq5100G7P10JeB2dUX1zCA+Iqo+TdSSDJKkQF8oz7Wg3A
         MtJcnRhlVpmG93TsNoyViQJhkE+lrzW8dDRzOo1Nvb+c38kb2aSZB8I+wlmyntv8unjg
         QWmBRqcf1I9lckhNJ76rDvUDjVx8yq607AqGc71PRQVOPofWu6z8WitTCDPxXDgPOr6U
         uWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717978059; x=1718582859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FynuwZtpDYUJAG2SjU3LA4RZtEXueend7py2Rk3AHE=;
        b=PteeS0fxDVCpJMGQhgV1iu4i6AUhF2ZRfP/E+vd4COPZ/zfGd7bX3c0Nj67+MXyzql
         AO57wTkGe14f8mB+AcTmWC+1NmV5D0LkRHAzU+Ng5/YwtzyIhKucSNe5QzTCxONz4ji0
         F80d9rayUejAh4ytNWAnx0KWOYULDCHrH7lsIEkEEEw2mrX0g5fL6CQ3jdhE8u5ivGop
         MaHzgBFvUD7iDUHVpVQNES8VNGlfJxDQkRZ2zb75uzQfmLtyH+rn8odWTOLMsqBTYXln
         wtAaVxc+VJuY5czHG65uWJPFwvU9JLdkvO6gDdJSjgNsIYdOo1FJX4NRzTaWOcX1MIWH
         BSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHs3kXm4F7rLPtIj/nLG4q4yE0u/AKy/4N2vCQruDcK/5afWmQZEnKfUMFsMS09r5z1k2bshEaTBvaYB1cc7ocpYVvxUf/kj+Ue8iO/IEC5346KsH3o8uuqgnOhg0j615j
X-Gm-Message-State: AOJu0YwIkR9aQMZaVXNIEwO7ssPBMx+cQTP+J0n/VntmZLIGuOu0vkd8
	1QUWFyUuCgkcDYZmbn4h0D+HrkYlWno6TRJOQZCqHC/g1gcA1A0U
X-Google-Smtp-Source: AGHT+IHkgHhlxIjcMwVqd9xbh+aWsrktaeoffRbMkIrdWhNmOrFx6ZZEWLa2fJP+zqR9Sit2r89HBQ==
X-Received: by 2002:a17:902:db05:b0:1f6:9010:1cb8 with SMTP id d9443c01a7336-1f6d03ce036mr78495325ad.65.1717978059441;
        Sun, 09 Jun 2024 17:07:39 -0700 (PDT)
Received: from localhost.localdomain ([91.199.84.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ededasm70188305ad.254.2024.06.09.17.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 17:07:39 -0700 (PDT)
From: Wei Fu <fuweid89@gmail.com>
To: oleg@redhat.com
Cc: Sudhanva.Huruli@microsoft.com,
	akpm@linux-foundation.org,
	apais@linux.microsoft.com,
	axboe@kernel.dk,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	ebiederm@xmission.com,
	frederic@kernel.org,
	fuweid89@gmail.com,
	j.granados@samsung.com,
	jiangshanlai@gmail.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	michael.christie@oracle.com,
	mjguzik@gmail.com,
	neeraj.upadhyay@kernel.org,
	paulmck@kernel.org,
	qiang.zhang1211@gmail.com,
	rachelmenge@linux.microsoft.com,
	rcu@vger.kernel.org,
	rostedt@goodmis.org,
	weifu@microsoft.com
Subject: Re: [RCU] zombie task hung in synchronize_rcu_expedited
Date: Mon, 10 Jun 2024 08:07:26 +0800
Message-ID: <20240610000726.146177-1-fuweid89@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608124237.GC7947@redhat.com>
References: <20240608124237.GC7947@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> 
> On 06/07, Oleg Nesterov wrote:
> >
> > On 06/07, Wei Fu wrote:
> > >
> > > Yes. I applied your patch on v5.15.160 and run reproducer for 5 hours.
> > > I didn't see this issue. Currently, it looks good!. I will continue that test
> > > on this weekend.
> >
> > Great, thanks!
> >
> > > In last reply, you mentioned TIF_NOTIFY_SIGNAL related to busy-wait loop.
> > > Would you please explain why flag-clear works here?
> >
> > Sure, I'll write the changelog with the explanation and send the patch on
> > weekend. If it passes your testing.
> 
> Please see the patch I've sent. The changelog doesn't bother to describe this
> particular problem because busy-waiting can obviously cause multiple problems,
> especially without CONFIG_PREEMPT or if rt_task().
> 
> So let me add more details about this particular deadlock here.
> 
> The sub-namespace init task T spins in a tight loop calling kernel_wait4()
> which returns -EINTR without sleeping because its child C has not exited
> yet and signal_pending(T) is true due to TIF_NOTIFY_SIGNAL.
> 
> The exiting child C sleeps in synchronize_rcu() which hangs exactly because
> T never calls schedule/rcu_note_context_switch, it can't be preempted because
> CONFIG_PREEMPT is not enabled.
> 
> Note also that without PREEMPT_RCU __rcu_read_lock() is just preempt_disable()
> which is nop without CONFIG_PREEMPT.
> 
> Oleg.
> 
> 

Thanks for the update. That's really helpful!

Wei
