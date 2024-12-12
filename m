Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248E13D52E;
	Thu, 12 Dec 2024 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028237; cv=none; b=GznKhA/0PRR7Aj02z5d4Nb/4meOBK1qPd6rKyTIeXYI++7oMO3kjZvDwcIP+3bMMN1tGVCq9NoqqG9MPZZLGQ2g6ZiGLf0n6kMS0l3xdEszw1n4emvWqc2D6qUDQKEUGIaRtbVUTArsfJMRJuOHfNBjZcUznibwhV8AQCKEpPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028237; c=relaxed/simple;
	bh=5nf9ux/Cf69Q8UJZhT4C6lwQ+XAMk771vuE4mhshYTE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rNgADLJfqmSIq6wx0sUvZK91L1tdMBxOC1bZ92xt/2vJzbC9rqH+Z8v7PR8XLBHZZgznIEZHymfGc4rg3OWipDmXAhx5FYQC64mggnNqk5mUqEcYT6A61FHr0+8Z3S+ZYFtbZC8eNJZoBPVyYbXnOPDj5b/cTeEq8kwTS+88Uww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=RomAY41b; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="RomAY41b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1734028228;
	bh=5nf9ux/Cf69Q8UJZhT4C6lwQ+XAMk771vuE4mhshYTE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RomAY41bZNZspmyg6+2I4w5wubdmo6SWVOaNsAFY9xu3Uuv3pjug0Y2luU3HqEyU3
	 VPmpR4epABliMOAJZYMMwaF8qzZvhFbyKTaqyWyrFVjg1a1sGWlY4m3PvaMKeanv/3
	 DRXtZ9HeS77MsaUZC/SLIQysKOh6h8KyVgK2A1Wo=
Received: by gentwo.org (Postfix, from userid 1003)
	id B6B77401F4; Thu, 12 Dec 2024 10:30:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B548B401C4;
	Thu, 12 Dec 2024 10:30:28 -0800 (PST)
Date: Thu, 12 Dec 2024 10:30:28 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
cc: linux-mm@kvack.org, "Paul E . McKenney" <paulmck@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, 
    David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
In-Reply-To: <20241212180208.274813-1-urezki@gmail.com>
Message-ID: <4f739c61-24c0-3790-8114-988f02c7caea@gentwo.org>
References: <20241212180208.274813-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Dec 2024, Uladzislau Rezki (Sony) wrote:

> This is v2. It is based on the Linux 6.13-rc2. The first version is
> here:

I do not see any use of internal slab interfaces by this code. It seems to
be using rcu internals though. So it would best be placed with the rcu
code.
