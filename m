Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7F1870
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724042802; cv=none; b=HHA+390cyJ+U9N639DZ8elTPGTtBU9wETp7Ieuz7IAlcdlcx9QNvE16gEm/ZuySGRR5Z2al/Rbhmfs8nLuTUdIi92Hk0VpLN5obkMmWH6rivUl5FSHR+gtxSO9ZCzBIxXtbGsTvy6eU31ZrvNwyXpBWnHiapSZ10raUVwdXkEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724042802; c=relaxed/simple;
	bh=OpVERxQj00mXeQH3YsmkjINmRblF+SAntyYw0o2TG2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9mp0kBr9zIRMrH4tcgwbVQ1AKbpe3v3Lwl2Nf1DgXLGipWYSW1ZSt0dyUEHSisQAzy6QDauV4lUr+dDGSYdh541uzYLpVPKslB1rM5stydxXB7ZZQ9oW/AfieE5HlFZsn9UhwxBLC0T9GfEHts+WSd4ImkBfEIwBMuBxrIe9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nMUjrVjJ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nMUjrVjJ"
Date: Mon, 19 Aug 2024 00:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724042797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G6RfAYvLi0VOKPq9whkZha3MPO+D7lmack/Vn1H3CXM=;
	b=nMUjrVjJo0Zmqs80KXGf37ng9TBTZUoKKag4FmWKj3y70s7IH3t+kjA9DcnUa0f8LfDP3+
	xX5hkzgD1nxo3FzR/BEVtmmOqzCgIBMViGZaO0w+AABACuorh489CjximVkPW60Uzn4vi/
	dCWW2QjUyIxwtnkt4+/5SH51pQA1kcM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: rcu pending
Message-ID: <wp42udo3pdqzjqlddtg7pca3uowil2pjaznx4liiqycpjlwis3@5kxso5kutoe3>
References: <lqtvpxcnp3mfs5pmaawfvfrcnz2vla7hfedgzec2louaxypjex@o6qzbt7snxoq>
 <617a8c07-4e26-4cf7-a263-552cfa070956@paulmck-laptop>
 <us7xrey4xz6zxou4u64bsebthodqzl33zrdo3pdgmf33q2bgjt@abf6a6c5x7ar>
 <11b7a42a-a11d-4efd-926d-1777f9e210a8@paulmck-laptop>
 <43crql5tqt2d7a65qxtaowpritjvvzoe72spvnb3temas33q5a@6qvk2an743wh>
 <b1ea0a2a-23c1-41db-a446-318e1eb7c429@paulmck-laptop>
 <6loibv4dmpwxbgavh3p2h2edf4hdyglmakxt6pvzoajdwnyypp@b4jrv7vyi3bl>
 <abc36602-20bb-4a52-b5f5-01c044700c50@paulmck-laptop>
 <a7zb6g6dgmm5hhkhw22u7lhbsgel2w3ntcaggoqoeblethx53l@uxef6ex25xwy>
 <f4c5bf95-da88-4633-ac9f-a626fdc332e4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4c5bf95-da88-4633-ac9f-a626fdc332e4@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Sun, Aug 18, 2024 at 09:40:27PM GMT, Paul E. McKenney wrote:
> On Mon, Aug 19, 2024 at 12:16:42AM -0400, Kent Overstreet wrote:
> > You can't use a fixed number of callback heads if there's going to be an
> > unbounded number of callback heads outstanding.
> 
> The number of rcu_head structures is your choice, based on your choice
> of data structure.  You can for example link together data elements that
> have the same value of get_state_synchronize_rcu() cookie, and use a
> single rcu_head structure for that group.  You could then do whatever
> you want for the linking.
> 
> But even if you do choose to have a large number of rcu_head structures,
> perhaps one per data element, there is no law saying that each and every
> one of them needs to be passed to call_rcu().  For example, kfree_rcu()
> requires an rcu_head structure in the objects passed to it, but in the
> common (non-OOM) case, those structures go unused in favor of pages
> of pointers.
> 
> So what were you really trying to get across to me here?

Like I said, this needs to run in a fixed amount of memory, so your
proposed algorithm doesn't work for having one rcu_head per seq with
pending objects.
