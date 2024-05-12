Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1520B3E
	for <rcu@vger.kernel.org>; Sun, 12 May 2024 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715511291; cv=none; b=ZweKG9RXuce0fCwU5akaA78x01JFUosA8pn8IqvwmLFfWum0lb+Q5aUIRalMVO49NhfquPALD+o6j4CDEq2C67RjnLJimlgP+bOn+qZg0BZrzvQKiA4J+pF3Wzon/rHcDRawmnhlijXQUSqAJzz36SsLTlL8fFQ+0Z4cS80pc34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715511291; c=relaxed/simple;
	bh=Emhf6vrwUmC6hxGQSQMrHGanPXhs5hnepzdRayKbrIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY6oQWQtxq+X28XE84FEdhUEkmOdQegKeA2V33DRmcoC7yWRiWP+nJdmgWeB4NN1lTTA7HytvwbOqRui5GheNVGpmjEkrjfa2dkzzK9uaUhwQkF4PH7r54y3vx3yfvt6jyMiM3kjO+etLTF1mvAX0vszV6gtiWtUjqVQoV78rjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xx0Y+bJ5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xx0Y+bJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715511288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FgfZ7MMddRAMv9DIXeUM0DVSkJbLcO39LCEJxsq64jI=;
	b=Xx0Y+bJ5UaKMloqyoABVFGGzx03I6MOXZpsJUkAZPN9Ps75udjgyKX2x68AxQazU5Q9I3/
	XX2Sr8mKrMyY2dZzTGb8Yjuur8uCJtwQkzQI1RgVNAOI32xe2XW3W4PMfS3HFjbHAC7+84
	5V4W4CfaQ6Y2WEcN6v3cTF+fZCCANrM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-oMn9CDSXMs6qPNq8DMF9Jg-1; Sun, 12 May 2024 06:54:37 -0400
X-MC-Unique: oMn9CDSXMs6qPNq8DMF9Jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DB84800206;
	Sun, 12 May 2024 10:54:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by smtp.corp.redhat.com (Postfix) with SMTP id 2643A966;
	Sun, 12 May 2024 10:54:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 12 May 2024 12:53:10 +0200 (CEST)
Date: Sun, 12 May 2024 12:53:06 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
Message-ID: <20240512105305.GB7541@redhat.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240509151312.GA22612@redhat.com>
 <f0a02cfe-7fc2-494c-8734-e5583f42a8f7@paulmck-laptop>
 <20240510113149.GA24764@redhat.com>
 <8ca02df3-5034-4483-8e64-3fc22eb14431@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ca02df3-5034-4483-8e64-3fc22eb14431@paulmck-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 05/10, Paul E. McKenney wrote:
>
> On Fri, May 10, 2024 at 01:31:49PM +0200, Oleg Nesterov wrote:
>
> > Why is that?
>
> Because I run KCSAN on RCU using Kconfig options that cause KCSAN
> to be more strict.

Yes, I see now.

> > but how can KCSAN detect that all accesses to X are properly marked? I see nothing
> > KCSAN-related in the definition of WRITE_ONCE() or READ_ONCE().
>
> The trick is that KCSAN sees the volatile cast that both READ_ONCE()
> and WRITE_ONCE() use.

Hmm. grep-grep-grep... I seem to understand, DEFINE_TSAN_VOLATILE_READ_WRITE.
So __tsan_volatile_readX() will use KCSAN_ACCESS_ATOMIC.

Thanks!

> > And what does the "all accesses" above actually mean? The 2nd version does
> >
> > 	WRITE_ONCE(X, X+1);
> >
> > but "X + 1" is the plain/unmarked access?
>
> ...
>
> In that case, the "X+1" cannot be involved in a data race, so KCSAN
> won't complain.

Yes, yes, I understand now.

Paul, thanks for your explanations! and sorry for wasting your time by
provoking the unnecessarily long discussion.

I am going to send the trivial patch which moves these WARN_ON()'s under
spin_lock(), this looks more clean to me. But I won't argue if you prefer
your original patch.

Oleg.

