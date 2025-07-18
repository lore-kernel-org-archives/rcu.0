Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7392F50;
	Fri, 18 Jul 2025 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849088; cv=none; b=bC6Lk9nou5TyI73ggquhOZNyXcsvqoRplJFc06AI1VSpD19Wd9N1UWtSZeLunqIUF1na4TsFoGzE0VgQHGYCImQ1ZKkv7+jjAf5LhO3404n4t2g9wLQDcuu/YZtFIA5B7zU0xNMFqwXc2pbmSLUzQ5AdtHes3FxCYQ6eBiiGu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849088; c=relaxed/simple;
	bh=qrs1bpx35x+FVsgjwSnIPEA7t267AK3IWAPm+onOYg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keXJYjn7KlKi0EJ4g72EUoKJX35Rs8yo2WbiK7u1QX1915kKz9yA2syo2FK2NyUsFdIHdV6QDGiu+cBQXClC7ebxWHZ3djAHEwehnuBFBl5FmrF9ucfG4N/trzWy52uSaj6onpEG3P21sulwqLPqLGjifLW2xK3fmFm4CWjj71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T0NopGKZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T0NopGKZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C+f6G0qeYvMfJLWbZqqOXaohYNJJGWVSAxUjQiRP0Ww=; b=T0NopGKZxNKGsmECuQx4IU6ls7
	XuthZDW74dFvGFpmyddPDjlZIAykk7gtcPt1CqEYolD8ykFk++CGrbGW7Mq5Z6WTSco0kcdorWiU7
	w0LWGprpfX32ItyuQPt00pKTv7G64RSMaPfH+UrAYF+1X05XFkCbo8HXSoPyx2SRgK/zcfibgugFe
	jLIhhTcjfLe1l6jV8NPjchQd94XuCsdEGkp01KfHhrC0Wz5j/bt4wWHSobNWM0orCgGDXal8IQdFR
	ycaknrRUEXrgzIz1xdBfYjWlNB/kbxXHfOKrVDAMZXdW4wqiXmNC6sLyB0D6Qz14BkVgGOXH6Frlo
	mmHRRs/g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucm6n-00000007P32-1dth;
	Fri, 18 Jul 2025 14:30:45 +0000
Date: Fri, 18 Jul 2025 15:30:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ye Liu <liuye@kylinos.cn>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH] mm: Replace (20 - PAGE_SHIFT) with common macros for
 pages<->MB conversion
Message-ID: <aHpalX_Rn111DsCE@casper.infradead.org>
References: <20250718024134.1304745-1-ye.liu@linux.dev>
 <416948e5-6308-4d57-8a05-d611522f5f2e@lucifer.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416948e5-6308-4d57-8a05-d611522f5f2e@lucifer.local>

On Fri, Jul 18, 2025 at 10:57:36AM +0100, Lorenzo Stoakes wrote:
> NOte I see arch/x86/include/asm/pgtable.h has a pages_to_mb() static inline
> declaration, but probably being an asm include can't ref mm.h so meh not a big
> deal.

Should probably go to linux/sizes.h, except that it uses PAGE_SIZE which
isn't available there.  But asm-generic/getorder.h might be a good place
for it.

(hm, is including getorder.h safe by itself?  looks like it relies on
something else to bring in the definition of PAGE_SHIFT)
