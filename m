Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166A10A11
	for <rcu@vger.kernel.org>; Mon, 27 May 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716839505; cv=none; b=cLOksvzecvVlhBSEgm9g8o/LLDNzynGlmbZrqYZ2G8bCjJMTzT+B9tfawPyOftKMkGSo4PTS6zCGtbsjYNCVQFF3Q3zdL4JgaVQdruxVLDep+D06VyWu29hIOkHQErqYunSx4hkto10cI6zpJU4BlfpKvhbBF1I10iTtgvgARV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716839505; c=relaxed/simple;
	bh=f23lt2txy29L7IbqHtWnWUQg7eRf7BOGCukkYHlKeUA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QAjKpGkOU5g1rc6HMh6QvWdmuvhmRQvHcx80lCUCT/oDGkwAnVpaVm/yFkZApgiJeYL12iy5W+MYdf7m9tenlbibyRwFHiiQHKK11ZhSLqNOGR2zR1SJOXRYGwKWhXMXDJUS5LvpPebnwhH8T09yyuPQG/yNbH7OgaHRAgxtORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=XxfKlNff; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="XxfKlNff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q3snwzwmWuoJD/WMzTv7X0Z3Dos/RKpUUf3kUzMbFkI=;
  b=XxfKlNffEX4U+45+4yhIKbR9JyMVXsFlPoR+7xU84Mj1JrMmRZj055D5
   zqjEDdW4i+yof9sfgJ5nMRHJto0/m2G/ywePMze2HuJpScribZXF9Sdf1
   d8DnTauqHqzF4AzZElh1EueqjVdJ9i1VArmaI9h11aC/bPieICIG5ncgf
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,193,1712613600"; 
   d="scan'208";a="167684911"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:51:35 +0200
Date: Mon, 27 May 2024 21:51:35 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Uladzislau Rezki <urezki@gmail.com>
cc: "Paul E. McKenney" <paulmck@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>, RCU <rcu@vger.kernel.org>, 
    cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to
 kfree_rcu
In-Reply-To: <ZlTjIDrnPb25UTUn@pc636>
Message-ID: <alpine.DEB.2.22.394.2405272151000.3330@hadrien>
References: <68b85796-c674-4691-936a-2051849f4692@suse.cz> <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr> <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop> <ZlTjIDrnPb25UTUn@pc636>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 27 May 2024, Uladzislau Rezki wrote:

> On Mon, May 27, 2024 at 12:27:14PM -0700, Paul E. McKenney wrote:
> > On Mon, May 27, 2024 at 10:13:40AM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Mon, 27 May 2024, Vlastimil Babka wrote:
> > >
> > > > Hi,
> > > >
> > > > one bit from LSF/MM discussions is that there might be call_rcu users with a
> > > > callback that only does a kmem_cache_free() to a specific cache. Since SLOB
> > > > was removed, it's always ok to use kfree() and thus also kfree_rcu() on
> > > > allocations from kmem_cache_alloc() in addition to kmalloc(). Thus, such
> > > > call_rcu() users might be simplified to kfree_rcu(). I found some cases
> > > > semi-manually, but I'd expect coccinelle could help here so if anyone wants
> > > > to take this task, feel free to.
> > >
> > > Thanks for the suggestion!  I will try to look into it.
> >
> > Thank you both!
> >
> I wanted to take an action on it but Julia was first. So, please go ahead :)

If you want to try, please go ahead.  We can compare results.

julia
