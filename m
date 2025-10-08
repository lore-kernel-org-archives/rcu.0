Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53368296BD6;
	Wed,  8 Oct 2025 06:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759903481; cv=none; b=U4/Ib4l2S+4Xd73lHR7u4J3PzAMUSZaVHfbGpUjwqolhVcJlMklp3xHR05BVngp7s6tb8ao5JeXTCKSTf2SDr0h4G7jP3eftN5grHbz97xwkX4sAJI7ldTXHPH0j4uiqyrDfFoFd7Y1jCsTuq2v20aiMIiFjrheH/hXcsiwsZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759903481; c=relaxed/simple;
	bh=9gBVmTr4OaFBiSGVa5HGdTny9W/pM69XwMzDwk/g0u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiEG76unIlBD3hI/sG2k5LKR5hi2fAVOPYWuAZMyjd9ogywPDVpm6hFsDUxnh/Dr2svL6etAhOhGdcEJvNLSD3i4X5rhraXQoXsi/Zmx9vQtZ8TNDz4ur+dGgiK+HgpOOPRaud7B1V+9yGKKctq+2/e4GKxqbfxQjmAKC9ECaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xIXq2OjG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xIXq2OjG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9i/hW2gsNIwvxGPBjR3UaQnJZD5u1DTKjwq3K7Rz45A=; b=xIXq2OjG57P+Qt2gk0FH0OvWkK
	Vd+ovtPhdeofYhBwG6boyowN0XgTdPjAZkmLA2CHdgmhSwYQ1e8LrpkUjOXt63w888HO2idXPbUjv
	gBFqaY7J7u2OP7puYZ3zvwJLi2fvAEj5w49jTK2iCAZGo20X1snDjfrARFJK0uMI1eo8VkAL3U2iu
	5GT1x06quwBEdppdk4fHQGr74EY5fP7bqoICxMgBrISd9jWPTGbQV1105mgcetFA7F0NlekJXo4p1
	r07Mk9iSassaNZu6epxkVWDPk2pukrHx2T3EE4odUIXfTvDZeBbu+sz9zi6Y5UVXXqZ6iDFGvJNuk
	CpBxUrqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6NHv-00000003GA6-11Tx;
	Wed, 08 Oct 2025 06:04:35 +0000
Date: Tue, 7 Oct 2025 23:04:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	WangYuli <wangyuli@uniontech.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v8 00/23] SLUB percpu sheaves
Message-ID: <aOX-87tPdtuPb9Uh@infradead.org>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <aOS0Z5N4HaBNeb_J@infradead.org>
 <c750ab62-a3d4-422e-ac5b-c531dfcc749d@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c750ab62-a3d4-422e-ac5b-c531dfcc749d@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 07, 2025 at 10:03:04AM +0200, Vlastimil Babka wrote:
> Basically it's for situations where you have an upper bound on the objects
> you might need to allocate in some restricted context where you can't fail
> but also can't reclaim etc. The steps are:

Ok, so you still need a step where you reserve, which can fail and
only after that guarantee you can allocate up to the reservation?  I.e.
not a replacement for mempools?  Just asking because I recently had
to implement a mempool_alloc_batch to allow grabbing multiple objects
out of a mempool safely for something I'm working on.

