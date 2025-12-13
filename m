Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599A35958
	for <rcu@vger.kernel.org>; Sat, 13 Dec 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765665110; cv=none; b=AgfGg1fBcTQF4fOvp9xwMOuCATftqe4bmS9Fzm5lKDUmYkrBC+SmQbHJ9fZqb0MNh5LBT0pbacYSI8nzVwzX6XbxkAx1GFOsLh8e3EjNWxxs2vUsjoOcJWXhFnKSSObzoYCPX0ztjbF7TrV/g5baheYucVi5A7Nn9oZnxuD9Obk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765665110; c=relaxed/simple;
	bh=IyP24J6AqMNnJ8WxY9vZQIzo6KtGk9LZN7MKy6GIdkY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WY+FbJqlfgKnEV397FAtt9mgafQGldemwzhepLywMBDC1dEk3jpIh2GQtEPZIZjPP1oAoC8e/4vzDsDOZErvI/NF+Hh843BPMWayPrTyCqofurXiGGNLvI7lfKG/9uYwBYuxz0sUi0C2jTnnfbv/GSNpM4XBgWIaAvBGN1FQCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8GqfnXa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8GqfnXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CCCC4CEF7;
	Sat, 13 Dec 2025 22:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765665108;
	bh=IyP24J6AqMNnJ8WxY9vZQIzo6KtGk9LZN7MKy6GIdkY=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=J8GqfnXaoFyZQIj+VLd+1nc/oBgMoIC4lOt0UfR+D31FKvy0UC1Bnad5pQBUMM+7A
	 Th68v4RznYzwmS6MMBELSdhv9J7S6h40Jer+acWrzLIEIsLLb1B41Y8EogHkF0GeZM
	 I2YN+kx0Q6GVpHhtN9UQzgaw571QafDwq5Vnc9+k3bF0tXLipeoQWZdf1rxyTtb74u
	 7oFoGRXYdy6o1CT9lPhGamNIl03VLxzhsZcln5VN0uuOEwAMp0Ry106dWpzF23mQng
	 rurHLX/UBcY+sjJm3ksitasMjs5vVB4tCR+Zp48mbrkNThMf2BJkaXLm//ZDA45Gwk
	 PBcmuKipi/w7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A8CA9CE0E43; Sat, 13 Dec 2025 14:31:45 -0800 (PST)
Date: Sat, 13 Dec 2025 14:31:45 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: boqun.feng@gmail.com, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, roman.gushchin@linux.dev
Subject: Handling large numbers of hazard pointers
Message-ID: <77ffb53f-91fb-4bd4-96d4-e16b0e6ff0f1@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I didn't do a good job of answering the "what about large numbers of
hazard pointers" at Boqun's and my hazard-pointers talk at Linux Plumbers
Conference yesterday, so please allow me to at least start on the path
towards fixing that problem.

Also, there were a couple of people participating whose email addresses
I don't know, so please feel free to CC them.

The trick is that in real workloads to date, although there might be
millions of hazard pointers, there will typically only be a few active
per CPU at a given time.  This of course suggests a per-CPU data structure
tracking the active ones.  Allocating a hazard pointer grabs an unused one
from this array, or, if all entries are in use, takes memory provided by
the caller and links it into an overflow list.  Either way, it returns a
pointer to the hazard pointer that is now visible to updaters.  When done,
the caller calls a function that marks the array-entry as unused or
removes the element from the list, as the case may be.  Because hazard
pointers can migrate among CPUs, full synchronization is required when
operating on the array and the overflow list.

And either way, the caller is responsible for allocating and freeing the
backup hazard-pointer structure that will be used in case of overflow.
And also either way, the updater need only deal with hazard pointers
that are currently in use.

Cue Mark telling me that his use case can have millions of active hazard
pointers?  ;-)

							Thanx, Paul
