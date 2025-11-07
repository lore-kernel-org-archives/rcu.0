Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFDA1F0E25;
	Fri,  7 Nov 2025 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519709; cv=none; b=tKRRk0ZCHmCOH6PQ6755yWqE9q6U9WISDqVRYXXZQgFDe4APVMinMe3zrVIzTHzfao93tzHhXMIs4nlL0lR73dukAb6lSgKQBWAycpNd5R9AOdJ1mDr/pBSPttgSqr9tYfhmbrNkZMRf7Qtbn5tPZxYEPmOk8g6qvIYdrXk/Qpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519709; c=relaxed/simple;
	bh=9qSpx02PB3M67S0+FIcoFz4YcqafdeNqSH47zWxo8Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maVmS8tRbuawtKbP8ncbKq4qOeFgJBWPZpqzk/tiHYbhDjmpvkNkBQVa4fhVUyI0W+0oxQc3424Tek0v49WXiOBzECsuBDkOF9fBK95fzqTJMqjyQPUTT1u5YPIGdp5+xUiSNr5t9AMzKlysHvzjEChU8NjyfoIU64BrAtoOIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWY6Uqs3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWY6Uqs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCFCC4CEF5;
	Fri,  7 Nov 2025 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762519708;
	bh=9qSpx02PB3M67S0+FIcoFz4YcqafdeNqSH47zWxo8Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWY6Uqs3xV0XnCp16NuZJIxZJ72EXVkK6J2LYghXf1r89fkeLr8IVZ5DevgjVFU+n
	 rVdsqfmf46QoMJRW8NqDOHJ6q1S0RrwGdOjUcyMWAGRCq/GbeOQDmK6BxAADaKXpht
	 fyS+ncUot5nHzz/FSfpot1pzhrRPqX9l7LJyyG84jd5BFoAflM9XNoMJBV9jynype8
	 rAcocx2dALGYG2bsdmG9tbwE9nit1zA1a74b7RMrQMhEzBypE8V3dZTZ2OUHl6B+7B
	 o7ApnNZrn8max5ngqQujon2D3PZAhDdthiC6BIQvkdqh966W1qxGIZvTYTMTRjWwhc
	 2Wf0fDjJNSvCA==
Date: Fri, 7 Nov 2025 13:48:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 0/16] SRCU updates for v6.19
Message-ID: <aQ3qmdoxktGZRUiL@localhost.localdomain>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <aQvXA3A5XHn-Tjhh@pavilion.home>
 <20251106110610.44599177@batman.local.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106110610.44599177@batman.local.home>

Le Thu, Nov 06, 2025 at 11:06:10AM -0500, Steven Rostedt a écrit :
> On Thu, 6 Nov 2025 00:00:19 +0100
> Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > Applied to rcu/srcu, thanks!
> 
> I have issues with patch 10, so please do not apply it.

Ok, dropping it, thanks!

-- 
Frederic Weisbecker
SUSE Labs
