Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949BD170A1A;
	Fri, 24 Jan 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739297; cv=none; b=BM9UyfzDnYA7o9Z4JBkFYWfBoh0qGwcWf1/vDXyFQsHHWDRL3K9yepGEdmx2h2njQ2Jn/25SFrL5RDLCaEkfYi4U08Z0Xg4t9+zjEg9uTK1j+fwoaLKu2hRoKjpX8xAuH55gklVJTKbHVCkXcR/UFXgqbcdG8dIse2Xh9iVXY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739297; c=relaxed/simple;
	bh=X52oJG4RuyTuT4ZKpXNkPyrxkZrkUeck7TIdtgHweY0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSaeeaw5Uls4YQwKlU0VHy9kbPg/UIW9aECtgb7bMHUud3RsSJvKkkXH0uZzU0b5N3bvF/FtJGHjY+dVIGuhXJpQX6h1HYNyY70rIl/cp3jvAAtIOxn6JTqbkbvvB/eEEcHHGJ2OApIiH7Qk8rIP2blkBapKW5ONQBQ+k/yR7bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGAFl7ue; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGAFl7ue"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-540215984f0so2505233e87.1;
        Fri, 24 Jan 2025 09:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737739293; x=1738344093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tjfgPtBliTFKKN/+LcagV6IBhXFcOjQbC9pGH0Wghp8=;
        b=MGAFl7ueZTIR6OgOP0L7gjF0mqQ5MAizwNvLbGIhf4CZgDyOM/d/T945VdoKwGc5N2
         U72n+V33soUg5Lozb7dxDIjX7DQ5ozrgbZXmUS8wfBMVLlZCfFuh/h0lJhDsUKsdh645
         DQ9IEZ2TF4Kd54p9D9UATX9+ztb3K73ODCw5X2iCWMKXIgbHBTIxUaBJyNxBseFgiAnx
         7RBuP9m15MzU8aaAojQtD3YXKmoY/ddOhTq15le8c5ZWvSAbUzowG6WxysLhlZw4jkD4
         X7KXa9ATGuar/iqSG2Zm/d36RNtP7ATPoR/NmSxsqv1ErnflqOox67RF0iCdMlQUNUoR
         oVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737739293; x=1738344093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjfgPtBliTFKKN/+LcagV6IBhXFcOjQbC9pGH0Wghp8=;
        b=C/eVM+Wsps/7llC9SnYaczqpL/BthDjqWcyG0LDRBuGApYekQyh0sohV1GVL7zx4Xi
         g+uE/UAMMLXhJtdXZ8op1Se1795OPWMhaw0eaFH+oUduRfBwbaIwpaVvyvPDIsgIssjn
         d6r/sXmSdpzQmO90NIuvJN4R8/R3LsQe7IKP47azZkGDcO45Vjp19mkx+0R8veZ2z2pN
         gqwNdlbkSh0QmvaJtbfPajmGyo8WBx8ORYqnaH0xdZbKG6r0J63KDrB98zKOtva54J5Z
         xzywvptu6P0Dt3qiMD27Da1PIhMBytaEYU+Ddv/TSxA8gW6ou/n36rvuozRpvrzTHYql
         4IFw==
X-Forwarded-Encrypted: i=1; AJvYcCWyX3VnPgzRnkk2f1Az+Rgi00bT31KokT6+fYR/IejreT4I+CkRXN3ad02vqcE4ysTDGFE0xKE/DPXKIi8=@vger.kernel.org, AJvYcCX/TOjRLTd3g51eMpHhNjK6Z4IN71v+CIXQLzNLt+C8MjhoQK7JIBuO6iP3mY3UoAuP67cf@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFIAD772wjoR/HTBRKvVVsKmzdi1oDKLyNo+Ch/qLaszX+4fi
	DzKaAysm1OcmNiLUC4zD9TWCfC6zf2rQl95gE97BSAyHutG0rHv0
X-Gm-Gg: ASbGncuu+cCMgS/xgcdKkPLM40K1FHcgTKne4pPXuAgBtkij5Xpo+qprqCp+oqzP+SC
	Todok5NtpAcZE5DDu23tFCQd4tWnGo5vjyrAojSsSk5cIhMw4DymS5hf3tWMm06K21L5TjgP3PM
	YiLkT1OZSO/pfhgrTxhisCKhnD3QMAt+N+1lYvyzga/E/VihAlwp0o5lie7R8+CPp2h5ILo2ldX
	SWkxdYPDmvbHF5EvHK8AveMEcGD+xK//W5VQxylsD2uSvlP3OktYtMuf2cEb9Swk79no6TGLBzA
	8lddPcuilYWv/knytTrTjRY5Ikbr167eQgo=
X-Google-Smtp-Source: AGHT+IFrlQpiBST/LwuiG6dRL4atqpbflveSuAj+ZJ3xzhczN4msXY2muMbjRxcwkPsOyrUq3IKAdA==
X-Received: by 2002:ac2:54a8:0:b0:540:2257:22ab with SMTP id 2adb3069b0e04-5439c253c6fmr10531567e87.27.1737739293174;
        Fri, 24 Jan 2025 09:21:33 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076bc49ca2sm4231991fa.96.2025.01.24.09.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 09:21:32 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 24 Jan 2025 18:21:30 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <Z5PMGlDb489VEZ7S@pc636>
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-2-urezki@gmail.com>
 <6f2969e3-344d-4f2d-a71c-ed999ac35324@paulmck-laptop>
 <Z5N8cmpD-HmTYQQJ@pc636>
 <d410ab83-515a-4454-8420-1ada8cf86efd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d410ab83-515a-4454-8420-1ada8cf86efd@paulmck-laptop>

On Fri, Jan 24, 2025 at 07:45:23AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 24, 2025 at 12:41:38PM +0100, Uladzislau Rezki wrote:
> > On Thu, Jan 23, 2025 at 12:29:45PM -0800, Paul E. McKenney wrote:
> > > On Thu, Jan 23, 2025 at 07:58:26PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > This configuration specifies the maximum number of CPUs which
> > > > is set to 8. The problem is that it can not be overwritten for
> > > > something higher.
> > > > 
> > > > Remove that configuration for TREE05, so it is possible to run
> > > > the torture test on as many CPUs as many system has.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > 
> > > You should be able to override this on the kvm.sh command line by
> > > specifying "--kconfig CONFIG_NR_CPUS=128" or whatever number you wish.
> > > For example, see the torture.sh querying the system's number of CPUs
> > > and then specifying it to a number of tests.
> > > 
> > > Or am I missing something here?
> > > 
> > It took me a while to understand what happens. Apparently there is this
> > 8 CPUs limitation. Yes, i can do it manually by passing --kconfig but
> > you need to know about that. I have not expected that.
> > 
> > Therefore i removed it from the configuration because i have not found
> > a good explanation why we need. It is confusing instead :)
> 
> Right now, if I do a run with --configs "TREE10 14*CFLIST", this will
> make use of 20 systems with 80 CPUs each.  If you remove that line from
> TREE05, won't each instance of TREE05 consume a full system, for a total
> of 33 systems?  Yes, I could use "--kconfig CONFIG_NR_CPUS=8" on the
> command line, but that would affect all the scenarios, not just TREE05.
> Including (say) TINY01, where I believe that it would cause kvm.sh
> to complain about a Kconfig conflict.
> 
> Hence me not being in favor of this change.  ;-)
> 
> Is there another way to make things work for both situations?
> 
OK, i see. Well. I will just go with --kconfig CONFIG_NR_CPUS=foo if i
need more CPUs for TREE05.

I will not resist, we just drop this patch :)

--
Uladzislau Rezki
