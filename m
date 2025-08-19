Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EF18E3F;
	Tue, 19 Aug 2025 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755570961; cv=none; b=KCURgJA6T2xaKfLta0n+HEfelOYlg45Wxuy+8jOKHwP+/C178Ajf8HHGkb7SgQfIosYkkLYtZ9l75DZ2mEg7BFURhcSdXQXnfrGuTgGT67ZeXKg2j91oSYB5UUGwkDkk8GHOPJdQlYOyZOmZoRp41f6ElzkIyNhq+TnTFLuei+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755570961; c=relaxed/simple;
	bh=YB6WUPSpspaizgFl347FQmQLBtab740JZ/pJYYXLjeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ+ikFa+jfkAV3rvdwMrv/+2f/R7V9cyGh5/wqVOvpblmSaVSFT45rG2Cs7NsKsiuxs585DU/O8LOqaVR3R7f0bumVfsyZ9deVqIPoZStXL57YnmNBXh8IMTa2nW3cxrN6Afc4bq+O+yMcfafa5Wl+QwnNQ2zW48kSHzm2RoNDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRw0eeg9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRw0eeg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50E2C4CEED;
	Tue, 19 Aug 2025 02:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755570961;
	bh=YB6WUPSpspaizgFl347FQmQLBtab740JZ/pJYYXLjeU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LRw0eeg92B6wjL2WHpTESLotyDy7KrHR5DRqHAUbmA0S1R7Lq+QxgkSkTk08ShnZq
	 c+uTywzHp5s9rVDGM3xR7onqkqDx8YzQsjUgc2mHtmyOfv7O1I3XwKg3PwuIRJ8Vix
	 UvXHP8meaIKC2LydXPg2CUKY7BVae7MqkTDDkcMzqjY+CRF/3ysp2sMxE56o7zuk9Z
	 +h+VUCr/LkGKl4YOEkQBYPUa7wXZ3MbncGmKo8ZHPlQ3MYzcKlQffi/WiYRviFd3Ks
	 WAw1i8n22mobDMJNFjCyBnOBqNZfV07OX9YNeNXIbMKZ6xb4MhaemPkXdsHYezCn3Z
	 5xGYFExoRXfcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 871D5CE122F; Mon, 18 Aug 2025 19:36:00 -0700 (PDT)
Date: Mon, 18 Aug 2025 19:36:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux RCU <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH 1/2] Documentation: RCU: Reduce toctree depth
Message-ID: <f483a724-1d63-4082-914f-dea8361d5c96@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250819012620.14606-1-bagasdotme@gmail.com>
 <20250819012620.14606-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819012620.14606-2-bagasdotme@gmail.com>

On Tue, Aug 19, 2025 at 08:26:19AM +0700, Bagas Sanjaya wrote:
> toctree index for RCU currently has maximum depth of 3. Since no docs
> currently use more than 3 section heading levels, this effectively spills
> the entire docs hierarchy.
> 
> Tidy up by reducing toctree depth to 2 (only showing docs title and
> second-level sections).
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

I pulled all three in for testing and review, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
> index 84a79903f6a883..e1be5b3c2c6773 100644
> --- a/Documentation/RCU/index.rst
> +++ b/Documentation/RCU/index.rst
> @@ -7,7 +7,7 @@ RCU concepts
>  ============
>  
>  .. toctree::
> -   :maxdepth: 3
> +   :maxdepth: 2
>  
>     checklist
>     lockdep
> -- 
> An old man doll... just what I always wanted! - Clara
> 
