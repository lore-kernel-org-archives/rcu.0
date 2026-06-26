Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7037C924;
	Fri, 26 Jun 2026 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782501640; cv=none; b=EOzGaFGv8kbUtpl5vNsriPYKuwZ5XG1PqmyAR0l/JbUAyOGYxB56qtsEewqwBi3WXWVbLA7XIvf0R4N364cq2HoTqS5o27hwnfSqvZsYU0SKyKa3GLJ6cxlk3zPXGqWbs1bo9gDBWXNbhmhQ9dpVhoQlXmu58Al09bXqfdFvc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782501640; c=relaxed/simple;
	bh=Vxcl7Wgoo0rQivWbomV70OfzEL5nZyf1PnmBKWpzK1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DZsWtfcWgM16eJBHUQhaUDf+zLqh62IEDR41pBIIS9dGy55xBnLwfP4I/+I7Ga8/mUIFdXfTU+/q6I3wKynJphxpycEEOhCzbAtVJa1ngbUqns51WaTmK1ZxJQ0MAgnxYCM+j0AvTlQ0Jgu/PRsvrQcLon1bZgHX5GD2turswQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqaB1cAu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqaB1cAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D511F000E9;
	Fri, 26 Jun 2026 19:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782501638;
	bh=pdZkFAQUGCMo43tYHIhF6sjy8xbBerhFoiWhHOi0eAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UqaB1cAuSYDEkZ4hzBTWmLod9MGJ68H1lI7tsa7Ig7kg21pl9D9QGFDaUV7teq8wJ
	 H0kTH4nuGZyLkwHSMeLFqHXxfIUnaqfBWYVrCH4OCnq9YyTzmL6eD6fqwAetJ1h1cq
	 bPUmPaFfiMU2MDmRhPkVQzFL2Tyvpx2hXQNHwX2rLAr7UOkYgGcs6s7rpCvhwPmfDh
	 KcKC6Z5LemS0z4LMV4jGmvQU2N/+YDLLC8Fq/SlnRKbPQcFeMvN63RVWzBnBovs9lH
	 Buy+tb8GT+nK5jFxn/FcvG8j42NAGGlpbZ5LYMdh1TPqh5GRt24eJwo/JBHffOaiKz
	 Wb7a5ZKEIC2RQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>, Usama Arif <usama.arif@linux.dev>
Cc: lkmm@lists.linux.dev, joelagnelf@nvidia.com,
 linux-kernel@vger.kernel.org, marco.crivellari@suse.com,
 paulmck@kernel.org, rafael.j.wysocki@intel.com, rdunlap@infradead.org,
 riel@surriel.com, sshegde@linux.ibm.com, ulfh@kernel.org,
 yury.norov@gmail.com, rcu@vger.kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, kernel-team@meta.com
Subject: Re: [PATCH v2] smp: Use release stores for csd_lock_record() state
In-Reply-To: <aj6stbjxAfjMaCUm@shell.ilvokhin.com>
References: <20260622163807.4187558-1-usama.arif@linux.dev>
 <aj0-SYJJdDzf56Ex@shell.ilvokhin.com>
 <19ad0544-7401-4050-b991-1cc374921e49@linux.dev>
 <aj6stbjxAfjMaCUm@shell.ilvokhin.com>
Date: Fri, 26 Jun 2026 21:20:35 +0200
Message-ID: <877bnlhzwc.ffs@fw13>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 26 2026 at 16:45, Dmitry Ilvokhin wrote:
> On Fri, Jun 26, 2026 at 05:30:21PM +0100, Usama Arif wrote:
>> > Since v2 is specifically about documenting the pairing, it would be good
>> > to make it symmetric and add the comment on the acquire side in
>> > csd_lock_wait_toolong().
>> > 
>> 
>> Its already documented [1]
>> 
>> [1] https://elixir.bootlin.com/linux/v7.1.1/source/kernel/smp.c#L275

Can you please avoid these silly links to a random source tree and just
tell people kernel/smp.c line 275?

> It is documented to some extent, but it doesn't explicitly state which
> smp_store_release() the smp_load_acquire() pairs with. I think that's
> the main benefit of these comments: making the synchronization pair
> explicit so readers don't have to infer it.

It's mandatory according to Documentation:

    "Certain things should always be commented.  Uses of memory barriers should
     be accompanied by a line explaining why the barrier is necessary"

which means it needs to be at the place where the barrier is used and
that implies an explanation for the pairing. It's a pain having to do
detective work to figure it out.

Thanks,

        tglx
