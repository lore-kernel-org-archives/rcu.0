Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15983A260
	for <rcu@vger.kernel.org>; Mon, 27 May 2024 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797626; cv=none; b=Z3PZ5WMVT5h+m7FLxrn95sShEUZnwPzz1XdMFmLkPLH8v/VPNX++r6RufPdyfE/xIPWtC5fWv/iFrY2wkIeiJs55HBzYjw7sJ/CNmz3fnrI5T2qHELjhIM93lbtdosW9V0kLxYAj+4swt9KEH3d7HVmU4WalnBOOiSVElimqgPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797626; c=relaxed/simple;
	bh=kS1XL0id/aPx6y/SL0JzWhHLrDYyiiXNEJBBrD73FDg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OTFFqvT0uVobcoNByCg2f0fj5ZpsGc26OGVQr6DRprQZtrpK4Yj+vrB/t0ZpPgV/Dvf/hSkfZCA4vWbwGiDQnZbUW8eZy8HO9JVEUJkOHKbMRMKIDOSKiIX6U0+/em7zRb2WfjNlumuN1F4CbMXdU080eMdxMUV4w6xmSVouA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Fk6eL86Q; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Fk6eL86Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=C5xkT9eTFRjnVxR+v3KkATuHOiwnnRLhAjHVnwvvRqw=;
  b=Fk6eL86Q8323h/cSC0isfKwdiqL9FynjK/Vnn4QDFvXWBEKxyOBFEKkI
   tUVwBbldG7GF15OVNyNWxFLdSTGpTQSnOJS2WEcMYHMszmddcLg3xC7tS
   LHuIt1tJu81LAu/ByTk/zakKZ0ze9bUFcJ1LIRcfN5oS7Z7RjraJe0J4K
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,192,1712613600"; 
   d="scan'208";a="167545742"
Received: from wifi-eduroam-84-071.paris.inria.fr ([128.93.84.71])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 10:13:40 +0200
Date: Mon, 27 May 2024 10:13:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Vlastimil Babka <vbabka@suse.cz>
cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, RCU <rcu@vger.kernel.org>, 
    cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to
 kfree_rcu
In-Reply-To: <68b85796-c674-4691-936a-2051849f4692@suse.cz>
Message-ID: <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr>
References: <68b85796-c674-4691-936a-2051849f4692@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 27 May 2024, Vlastimil Babka wrote:

> Hi,
>
> one bit from LSF/MM discussions is that there might be call_rcu users with a
> callback that only does a kmem_cache_free() to a specific cache. Since SLOB
> was removed, it's always ok to use kfree() and thus also kfree_rcu() on
> allocations from kmem_cache_alloc() in addition to kmalloc(). Thus, such
> call_rcu() users might be simplified to kfree_rcu(). I found some cases
> semi-manually, but I'd expect coccinelle could help here so if anyone wants
> to take this task, feel free to.

Thanks for the suggestion!  I will try to look into it.

julia
