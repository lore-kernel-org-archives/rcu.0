Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0341FAC48;
	Tue, 22 Apr 2025 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745363189; cv=none; b=PmIlH3X/vULKMJ60kTSPB2DxKk6o3T4422L+9ZngOfbk2yZQdneTc+hYrP7c9BrtDGq1UZgVDNmrwknf3riYU/Gn4/iS2KTT/3fuW7D1UzcJ2TYepl4VuGd2H/2HbMW3oC1hVZL+4oBlGS3l2fWZu1ftxnB9FnpJHBl14AjoXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745363189; c=relaxed/simple;
	bh=bwgCTZYImF7dMiY1Pe1Jqt9Q0rRWFEzVt9QQ4INAHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tS+tHMBZ+2SlGKGZHVyc+33w5B4vQ4aMZhhAo1cflZhpRATFIC5Xm+rYby8yVa8AKyFd3eKfQGhIuYuistpLBm3+cX29HFbI5MLJt7zZzFfUC+2Jd1V1HtbVBJTbd1Hw7SMZKStvNChrgeLOECmfbX5clBNfcCJe0tVT8YT6D0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxBbAKNA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxBbAKNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034DBC4CEE9;
	Tue, 22 Apr 2025 23:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745363189;
	bh=bwgCTZYImF7dMiY1Pe1Jqt9Q0rRWFEzVt9QQ4INAHVU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rxBbAKNAnitEV35sJjP5hOcIsaWa2vjiSqyIjzdHwQzII/UF9MVaqVII5OW/TJ4Or
	 bbAWhY6aaNXe6pq8dNSR6aSEjw0ucWlhSb1jZYEUBK8Pc83rnXPi4r87SXJmaXi+Q6
	 o0GFHI8HzNRk+c8y7Gqc8yKfZ3NvRWf1zpn4wiomMWEukOSQp3ciTtWKIHa+EaoxMA
	 iic/gxcSsrqHXzTizezNXennLpRyg1e22rmB4WtcTlMbCgX8/6ebjWiLt4RI+/heJS
	 C4DjW3zA1Zng2/XENlqFm6Hn7wsx+mkCsFTw2J4OdfYF4JLQAB9IBtBOBu2oES5BC7
	 i1rKGFQoXW2/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94DE7CE0875; Tue, 22 Apr 2025 16:06:28 -0700 (PDT)
Date: Tue, 22 Apr 2025 16:06:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] tools/memory-model/Documentation: Fix SRCU section in
 explanation.txt
Message-ID: <130ce800-1bcd-47c0-9058-48e820738852@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250422173830.90647-1-urezki@gmail.com>
 <1497ef3c-b1fc-4723-949b-28d92a3afb6b@paulmck-laptop>
 <1a9388fb-83ff-4345-ab2b-6c1825913d71@nvidia.com>
 <fd718b41-a812-43a3-973b-b07a1381f062@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd718b41-a812-43a3-973b-b07a1381f062@nvidia.com>

On Tue, Apr 22, 2025 at 06:56:17PM -0400, Joel Fernandes wrote:
> 
> 
> On 4/22/2025 6:55 PM, Joel Fernandes wrote:
> > 
> > 
> > On 4/22/2025 1:56 PM, Paul E. McKenney wrote:
> >> On Tue, Apr 22, 2025 at 07:38:30PM +0200, Uladzislau Rezki (Sony) wrote:
> >>> The SRCU read-side critical sections describes the difference between
> >>> srcu_down_read()/srcu_up_read() and srcu_read_lock()/srcu_read_unlock()
> >>> in a way that a last pair must occur on the same CPU.
> >>>
> >>> This is not true, the srcu_read_unlock() can happen on any CPU, but it
> >>> must be performed by the same task that invoked srcu_read_lock().
> >>>
> >>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >>
> >> Good catch!
> >>
> >> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > Applied, thanks.
> > 
> 
> Oops, though this is memory model and not RCU per-se. Paul do you want to take
> it or should I? ;)

Heh!  I will take this one.  One of those days, I guess!

						Thanx, Pau
