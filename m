Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF132E143
	for <rcu@vger.kernel.org>; Tue,  4 Aug 2026 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880743; cv=none; b=b2+sYcfHtpdvL9tExvobXmgV/lSJyJTySyZo8NL62AEm2U6mNauQtVggUg047OfYiGNEL4u96WAapNvu9G+IwOUDVOmCEGVlazS+PWP5ftpkmQw15qk3mqM52j/3NWa9W7vqhtZmfL+jFWUaSyhoqFtupjPqmgaFUNEzIxROVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880743; c=relaxed/simple;
	bh=qOIs+i9QQUsSu3Ql8XNYkaw2u1Mk+UvlZjVhVI3WBTs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=p4bEcH7lL/4eiZW7dEiy/cuSXU1K5kF8aX/tx8apYwZ7aVOLkdJUDDMDT3AmE3BobuZdrgGwcydW7a9Fdfzaz6jni8lJ2by2ANNYP6Ilt4nPTKKer4fsodmJXOOlcYOjZ4e8D1p1T5DiG8RhjRgwxVDLPsYlOcDZs0MP/BwCOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mtGb2nY7; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mtGb2nY7"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785880739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xVRaI5b6+VHx5BadPYeQjaOdauKJNSVroL9t8oqDvE=;
	b=mtGb2nY7DFMsT+aMhupg9h1IbDBxcnnjHNnHiQ798n2DJbxK/es7rWFiSGUAjK/cyV89E9
	yQ11EeDQvMs8TFiYoUEHaPDc5zGpqRu6w7wZgLnovQ6AMTtZMp4eH76Ki/D/nRhs/RpCW/
	i5Af6ZrVq1I8hLs1o7NnA/1Ky4RZSg0=
Date: Tue, 04 Aug 2026 21:58:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <01484cd339ea024dd7c01f02a9781f00e67cb52d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] srcu: Queue sdp->work when the delay timer is
 successfully deleted
To: "Breno Leitao" <leitao@debian.org>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, urezki@gmail.com, boqun@kernel.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <anGc7qa8fzrDf7dp@gmail.com>
References: <20260709100602.821-1-qiang.zhang@linux.dev>
 <amzfBSSGyVF0vyQ9@gmail.com>
 <0bba3fa18b116a3b08e3e83310b3197bcf780000@linux.dev>
 <anBxXePfyHY2Uz0d@gmail.com>
 <68038c37bd588be7df2892e85ec9bab31d20cd34@linux.dev>
 <e3738457818909e56c8aa5aef99d8b3e26a328d3@linux.dev>
 <96d6edfce3ac43e153a21b23994251ede0fbd7f4@linux.dev>
 <anGc7qa8fzrDf7dp@gmail.com>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Mon, Aug 03, 2026 at 11:40:14PM +0000, Zqiang wrote:
>=20
>=20>=20
>=20> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >  index b9fe57ff9100..d13c12f61150 100644
> >  --- a/kernel/rcu/srcutree.c
> >  +++ b/kernel/rcu/srcutree.c
> >  @@ -751,8 +751,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp=
)
> >=20=20
>=20>  // Call srcu_barrier() before this cleanup_srcu_struct()
> >  // to avoid triggering this WARN_ON().
> >  - if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
> >  - rcu_cpu_beenfullyonline(sdp->cpu))
> >  + if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
> >  + rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
> >  + rcu_cpu_beenfullyonline(sdp->cpu))
> >=20
>=20Isn't the WARN_ON() the same? thus it will hit again?


WARN_ON(timer_delete_sync(&sdp->delay_work) && rcu_segcblist_n_cbs(&sdp->=
srcu_cblist))

Thanks
Zqiang

>
