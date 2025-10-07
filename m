Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C983208;
	Tue,  7 Oct 2025 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759818861; cv=none; b=XEdSVwKFNxUDUgFcun1shjpEtj6RQ40m2aX0f9EA+chpvaa/rCh7caf7cSbTngzKuOHvRI0gePi6HPJXYOlVbxIkVK5QY+JvhLf2lBK8JCgb4sDoIm+slDJp2hJP1McmuUi10gJ4w/+pZ2ioF/ZR5X9YXOD6OuTpQUGuOM+s3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759818861; c=relaxed/simple;
	bh=rb4OsNVu0Iz0mr+t9D7Pj11EdTEkOSc1p1lYVENw6OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPhvsSaY8dhviyG6Jw/Ao3/rYfh68GRW+I+UqkJDbbp4PRXyr3o4JOfFIrGwkNQAT4KfenBqFpADW4qJnGm4q3PRenxcE7Km4ST4+MgF2A9JArf4KF9/VAQuxR5vUQi0sg7KaoUcCTvL6s8CeuWtI+WtpZHkv8rXcTWMBHosCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wK8UyY/F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wK8UyY/F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uVfcmzXuLVfDwhNrv1TlHQB+p2roeVM6ucFNuJd12fY=; b=wK8UyY/FgUQyb31PnejaUKkwpa
	XEmwvUlS6rQgQiXB2qWa7aS7EsrDolYMqYvooT2UVavUZenjq2NxqnmoCKCzOZ2cOBN6yW4DmkuNK
	xFNNlLVvx4/30OiectqlKBAsfZnhsFsZl2k27nF5LiJzB/2hyNh3/+k/YoMOmtSsSwDVBw0ahzG25
	wr3R2NtaaeC9cqtM1QBLm05Ed7NAiZdcBF5Tpx1K9r8mwwd57kxn8/cGC73Xzj+F91L8YbdFBKo18
	A2g4K7iFyWynn3zK3JIZZ6mrkVV01bP6qZU/56mHIZILVfBtdRrtHPCRHWcMLDmGR23vpjwkqpEG/
	yvzyl5yw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v61H5-00000001NCF-2XwD;
	Tue, 07 Oct 2025 06:34:15 +0000
Date: Mon, 6 Oct 2025 23:34:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
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
Message-ID: <aOS0Z5N4HaBNeb_J@infradead.org>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Sep 10, 2025 at 10:01:02AM +0200, Vlastimil Babka wrote:
> Hi,
> 
> I'm sending full v8 due to more changes in the middle of the series that
> resulted in later patches being fixed up due to conflicts (details in
> the changelog below).
> The v8 will replace+extend the v7 in slab/for-next.

So I've been reading through this and wonder how the preallocation
using shaves is to be used.  Do you have example code for that
somewhere?

