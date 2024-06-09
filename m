Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658AC210E4
	for <rcu@vger.kernel.org>; Sun,  9 Jun 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717947474; cv=none; b=uOgDJmmb00DVuR7+dGBvdq5ru3vnuk91Q0KZtjLZmFfcf2rRChLerYFo8n6O8qvP07E868lJZTn1QGWq/l4TegeDwFQ+8fnlumEyXS4jFa+ru7T+LAJMWOGgnFIiZntiHwVTurlUT60Q5hqseXxu8Y5PYMW/6ybKL7JZqL56Vbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717947474; c=relaxed/simple;
	bh=PEApBEehHYoY6VAehdFcgo4mi1Oo7DLz5XgH8O3CDkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofkZ5Aj0JFmizsGrbkMri7a4e/C3IqM3Eo+7ATit16DrA1MvSp/EVSVcwMrnwWav5CH6SqZxJnHWB+lmqeJVojjOUzVFNCcjo5OhP/JunPVdyTE26RK/ULG68zD3TFV1+gTRCG6i3LNeo1NolYXuH75SrZSyALkKH5fUgGZUVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fzqp1zoN; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fzqp1zoN"
X-Envelope-To: paulmck@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717947470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rX2lEepbyTUPRU+5otq7AalCY8/7B5AIzZ0E56fgvew=;
	b=fzqp1zoNvjYt2VTy5grw7GRs+HCJSO2sYPqaS4CzBgUE93QvklLEFQaZWtHfYCZgBQ/Vow
	OWLeAm1gNpfcsJ+R2yV+l6RUHXilqFzEfVagi2O49jDYRcuOfCInxPvNSS8rEGZJflm8NB
	9px6um5BIcOWkNIYYIZLw7Cc08SaP00=
X-Envelope-To: rcu@vger.kernel.org
Date: Sun, 9 Jun 2024 11:37:45 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
References: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
 <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Sat, Jun 08, 2024 at 08:25:53PM -0700, Paul E. McKenney wrote:
> Could you please try something like this just before the call to
> cleanup_srcu_struct()?
> 
> 	WARN_ON_ONCE(poll_state_synchronize_srcu(&c->btree_trans_barrier, ck->btree_trans_barrier_seq);

Which seq was this supposed to be? All keys have been freed by this
point...
