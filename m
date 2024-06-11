Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0999F3FB1B
	for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124003; cv=none; b=b8F07M5npMdEp80ETl2hKq0Rwj6xVtRhcr+NOm0W8qRMQ549047c5V27nkXwEKXE6S7pmSPAZ8PO55FKPH0Nef9eWy42KPnR9UKRba1hzvcb4OeETscgdxReII7Yb1Eeg6Q0gYLNRcrzGPSoeIItZrd8/YGGtw+ixDzvV3jrGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124003; c=relaxed/simple;
	bh=rJwpe6WsGUWjXuUZkkQQNudmMn9xykQq11ktoPrSWoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+VV1FmC7e7tTLkebdEv6dY7KDAjM3hLGSVbV7rJyw07XLEpuKayZu0eeH4iVN4TfQOJCPzkj/HDDuGcRyJlQ+8b0xXpYJbxBHEcM+iyofJrE6Mda+hl4jChkT3PdW2MoS8fnpreactb8E2CFGh9n4fs2XYK5BoIIn3og0FLN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A473868BEB; Tue, 11 Jun 2024 18:39:55 +0200 (CEST)
Date: Tue, 11 Jun 2024 18:39:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <20240611163955.GA12787@lst.de>
References: <20240611152055.2317197-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611152055.2317197-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 11, 2024 at 08:20:55AM -0700, Keith Busch wrote:
>  	mutex_lock(&ctrl->namespaces_lock);
>  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> -		if (ns->head->ns_id > nsid)
> -			list_splice_init_rcu(&ns->list, &rm_list,
> -					     synchronize_rcu);
> +		if (ns->head->ns_id > nsid) {
> +			list_del_rcu(&ns->list);
> +			list_add_tail_rcu(&ns->list, &rm_list);
> +		}

Is this actually valid for a (S)RCU protected list?  If the entry gets
added to the new list before the grace period has completed, we could
trick a concurrent traversal into following the new list unless I'm
mistaken (although chances I'm mistaken on RCU corner cases aren't that
low..).

