Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD7171C1
	for <rcu@vger.kernel.org>; Wed,  8 May 2024 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149165; cv=none; b=cfxvQbInYzWOrx/mJIrztqb/C0sxnI4sUCEyELQiFERXCVYYFwe0kmwL0SjN26rqPoHWVKHocGdMXS7VbjsixSC/jyXCItad4DDmHtBptDU/rVDltr7QqPyMY7zEEAeSg8Nyxsyon7oDh9kUYNhy8kSfpikk6/aQrzbdglEOZCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149165; c=relaxed/simple;
	bh=DymN4p2A+Vsge2z/Iye6njrMgcg+Mh7xY36mVnu2GZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=Eq9cCgmX7b48p2ng9DeBMMsBs0CSb1lI1jav51c3obwEVeY83qqk9PThrXRzzFlJy9Zr3miPKZsTlXDA06bjyCLCHQ8u84yFAZsuTj28K3nuxTYS/PVbgJjh1Xl8GbiEtgj3+jh/ihbpY77dfC3pT3I+9X8jGKJ/a/PUzFdM0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGKzFvk/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGKzFvk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715149163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBdAW+sq1bhL2ar45eOYIKwIreP2ij4Hd9fZNz+NXM8=;
	b=CGKzFvk/77J+Xb7OJfkOrAVkox7WFhMnlK3KBX7LZ7QLBjgBJbag4rgyZNtw89ES06Po9Z
	Z5B2l4ba3KONklQx2rUCjq/64Cw2KfkM9qN6fxN72a+ys6WBUk3dux/x+v6oJCrxV40jqw
	vgNnp2CV0fNGNHAsKGstnu6fGvbHxik=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-7aemxMu3NaeEtUR-BA9w7Q-1; Wed, 08 May 2024 02:19:21 -0400
X-MC-Unique: 7aemxMu3NaeEtUR-BA9w7Q-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1ecd9a80d84so4469135ad.0
        for <rcu@vger.kernel.org>; Tue, 07 May 2024 23:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715149160; x=1715753960;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBdAW+sq1bhL2ar45eOYIKwIreP2ij4Hd9fZNz+NXM8=;
        b=onKmR1jeBp5Dxr4krrfqra1LTXXgMddj+ZzX7LMxP3AaneR1cXpeQpOAsx7EFrF+oD
         jxayaPZnvhBoY7VH1bnagPLVJt0/WeXnbl65QgY/45kxIG4yAAm2BYI9Tx2/5lxINrTL
         clg2MCubf4zlcqJwU7r0DdA+c09/nNHgpVBlR4MTPoFlOFvPFJajeMs1pnGMEMge0CuF
         BuY/laorWs/mvKjnHJE6aozvd8Qu9Pf7U7K2v2gNywqAliDl0lLPpo3GOHu2xiVcD+bQ
         cZZ1dSZu4KrabNsRFQtemTUW3EQksriDf4lpc3aiFTA1opURHt16WevcumVhsn3Z1gsB
         B6uw==
X-Forwarded-Encrypted: i=1; AJvYcCX5/OjLRxBdsae9nfEPrVNxFrbUiGl+aUVrs+1rG7pFWiAejFhBtqGCG+9p12cpZX63T+bN2zF9dio5vcD7poZAym80
X-Gm-Message-State: AOJu0Yyf5Yrd3cVSQ/ukLjmM9wiYv6AGw2lcpFRNZ7EiScD8gF195gt9
	Yx5wNsh2IFqmo+GwDBAo7dM/SX4u6DXZ3VkQHzSygJe6lMixyuOPGDCkVNyw6gXg4dNK84poMbF
	3zmGGOt//zaiHKiGOqPK+wcsKz08XhKMo1si+jrhKI/EIEV61Ng==
X-Received: by 2002:a17:902:d4d0:b0:1e2:c350:b46a with SMTP id d9443c01a7336-1eeabea279cmr32410205ad.27.1715149159987;
        Tue, 07 May 2024 23:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtl1BMIXs3xkD1ba/7xv/mpVang9p6KrOLPt7qYZ+54pR3izGDMTZWZji2krpwzlhX/nbo+Q==
X-Received: by 2002:a17:902:d4d0:b0:1e2:c350:b46a with SMTP id d9443c01a7336-1eeabea279cmr32409945ad.27.1715149159537;
        Tue, 07 May 2024 23:19:19 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:4b0a:b7a4:5eb9:b8a9:508d])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001eb2fa0c577sm10999265plg.116.2024.05.07.23.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 23:19:18 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
Date: Wed,  8 May 2024 03:19:01 -0300
Message-ID: <ZjsZVUdmDXZOn10l@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <b44962dd-7b8a-4201-90b7-4c39ba20e28d@paulmck-laptop>
References: <ZjVXVc2e_V8NiMy3@google.com> <3b2c222b-9ef7-43e2-8ab3-653a5ee824d4@paulmck-laptop> <ZjprKm5jG3JYsgGB@google.com> <663a659d-3a6f-4bec-a84b-4dd5fd16c3c1@paulmck-laptop> <ZjqWXPFuoYWWcxP3@google.com> <0e239143-65ed-445a-9782-e905527ea572@paulmck-laptop> <Zjq9okodmvkywz82@google.com> <ZjrClk4Lqw_cLO5A@google.com> <Zjroo8OsYcVJLsYO@LeoBras> <b44962dd-7b8a-4201-90b7-4c39ba20e28d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 07, 2024 at 08:22:42PM -0700, Paul E. McKenney wrote:
> On Tue, May 07, 2024 at 11:51:15PM -0300, Leonardo Bras wrote:
> > On Tue, May 07, 2024 at 05:08:54PM -0700, Sean Christopherson wrote:
> > > On Tue, May 07, 2024, Sean Christopherson wrote:
> > > > On Tue, May 07, 2024, Paul E. McKenney wrote:
> 
> [ . . . ]
> 
> > > > > But if we do need RCU to be more aggressive about treating guest execution as
> > > > > an RCU quiescent state within the host, that additional check would be an
> > > > > excellent way of making that happen.
> > > > 
> > > > It's not clear to me that being more agressive is warranted.  If my understanding
> > > > of the existing @user check is correct, we _could_ achieve similar functionality
> > > > for vCPU tasks by defining a rule that KVM must never enter an RCU critical section
> > > > with PF_VCPU set and IRQs enabled, and then rcu_pending() could check PF_VCPU.
> > > > On x86, this would be relatively straightforward (hack-a-patch below), but I've
> > > > no idea what it would look like on other architectures.
> > > > 
> > > > But the value added isn't entirely clear to me, probably because I'm still missing
> > > > something.  KVM will have *very* recently called __ct_user_exit(CONTEXT_GUEST) to
> > > > note the transition from guest to host kernel.  Why isn't that a sufficient hook
> > > > for RCU to infer grace period completion?
> > 
> > This is one of the solutions I tested when I was trying to solve the bug:
> > - Report quiescent state both in guest entry & guest exit.
> > 
> > It improves the bug, but has 2 issues compared to the timing alternative:
> > 1 - Saving jiffies to a per-cpu local variable is usually cheaper than 
> >     reporting a quiescent state
> > 2 - If we report it on guest_exit() and some other cpu requests a grace 
> >     period in the next few cpu cycles, there is chance a timer interrupt 
> >     can trigger rcu_core() before the next guest_entry, which would 
> >     introduce unnecessary latency, and cause be the issue we are trying to 
> >     fix.
> > 
> > I mean, it makes the bug reproduce less, but do not fix it.
> 
> OK, then it sounds like something might be needed, but again, I must
> defer to you guys on the need.
> 
> If there is a need, what are your thoughts on the approach that Sean
> suggested?

Something just hit me, and maybe I need to propose something more generic.

But I need some help with a question first:
- Let's forget about kvm for a few seconds, and focus in host userspace:
  If we have a high priority (user) task running on nohz_full cpu, and it 
  gets interrupted (IRQ, let's say). Is it possible that the interrupting task 
  gets interrupted by the timer interrupt which will check for 
  rcu_pending(), and return true ? (1)
  (or is there any protection for that kind of scenario?) (2)

1)
If there is any possibility of this happening, maybe we could consider 
fixing it by adding some kind of generic timeout in RCU code, to be used 
in nohz_full, so that it keeps track of the last time an quiescent state 
ran in this_cpu, and returns false on rcu_pending() if one happened in the 
last N jiffies.

In this case, we could also report a quiescent state in guest_exit, and 
make use of above generic RCU timeout to avoid having any rcu_core() 
running in those switching moments.

2)
On the other hand, if there are mechanisms in place for avoiding such 
scenario, it could justify adding some similar mechanism to KVM guest_exit 
/ guest_entry. In case adding such mechanism is hard, or expensive, we 
could use the KVM-only timeout previously suggested to avoid what we are 
currently hitting.

Could we use both a timeout & context tracking in this scenario? yes
But why do that, if the timeout would work just as well?

If I missed something, please let me know. :)

Thanks!
Leo

