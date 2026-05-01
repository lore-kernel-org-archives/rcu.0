Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7D9382F24
	for <rcu@vger.kernel.org>; Fri,  1 May 2026 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777629082; cv=none; b=nraXtV/jNTkMJxcRFJR+88pQX+/HMvofe93OkNlMW6zFirdTBml5cVbIv/d/rD4fUuX7ir+11oV6dTP0itkyvF+gQzsezPNo+Ri1n9NCHWwzrNx4jvdGN7CYh01zEPtFg8DomaqvydQkNSUpb/pcDCgZQ0hXDTj2K8yZFCbUPqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777629082; c=relaxed/simple;
	bh=iK/inTQXXe2W33q+2ejIJxYil1ZGxCcgNGcNTjVfVqE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=XTa5qP7IkZGu1qQY/wdxvPkkmntBrWYvfJWTyIAWv6FrNOVZkbbmXwBBCGta/Nd+2dkDTiCpLPoFBV6qNzn2HLqrCLBTX5e0YZOVptDhkbLpuk5ObJNbRREtuHE81eFmlDbosvbSur8kcsWH0g7YzdMeQpl/1L8U26FT+7doGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZtfcCaLa; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZtfcCaLa"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777629067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXdFBx8l3tGZes4ujoaocRj3EKhi8wM6pgwvAxaoGBA=;
	b=ZtfcCaLazBolB4/VlQ0LaPzoKu4Ng703NTgA/qwXY4I9AkgFiMOnWok7yaN/V6hCT9PVcL
	LVveJlxCP8Ts2wTfD5kL7fqk8XtnUYrQGURP2rNEBCPwYCOeg88JXXWrmd5YN0WOtM/0wD
	8nsmz2nwggH+JScFjPlRrrQ9/Wbrjbg=
Date: Fri, 01 May 2026 09:51:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <a66e8fbcc197cd25b234d946f818f97d6b76bab8@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH 0/3] srcu: KVM: Add, export and use
 call_srcu_expedited()
To: "Sean Christopherson" <seanjc@google.com>
Cc: "Lai Jiangshan" <jiangshanlai@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Josh Triplett" <josh@joshtriplett.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, rcu@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Nikita Kalyazin" <kalyazin@amazon.com>,
 "Keir Fraser" <keirf@google.com>
In-Reply-To: <abSZyLff5y-IQ0Ix@google.com>
References: <20260309193059.2244645-1-seanjc@google.com>
 <067c53cc-b015-43c6-9ba3-c734eff17819@linux.dev>
 <abSZyLff5y-IQ0Ix@google.com>
X-Migadu-Flow: FLOW_OUT

[...]
> I'm all for a general solution, but that's far, far beyond my SRCU know=
ledge level.
> I was quite proud of myself for piecing together the incurred-delay. :-=
)
>=20
>=20FYI, I'm going to be unavailable for ~2 weeks. Nikita (Cc'd) can like=
ly help test
> potential fixes.
>=20
Hi=20Sean, hi Nikita,

Some data points on the RFC scenario.

The setup follows the pattern discussed in the RFC:
a call_srcu()-like path that can start a non-expedited GP,
followed by a synchronize_srcu_expedited()-like wait on
the same SRCU instance.

KVM selftest setup, BPF tracing.Single VM, single vCPU.
Guest holds a long measured window (~8s, fixed in selftest).

Baseline:
  In 5 recent 10-run batches, the no-preemption case produced
  a single >1ms sample in total.

With same-CPU preemption:
  >1ms reproduces consistently and shows up in most runs.

For >1ms samples, sched_switch/off-CPU attribution lines up
with switch-out in the same measured window.

In this setup, >1ms is mostly off-CPU time,not continuous in-CPU executio=
n.

Question on the original report:
when synchronize_srcu_expedited() delay was observed,
was the host mostly idle/bursty, or under steady load?

Can share repro details if needed.

Thanks,
Kunwu Chan
