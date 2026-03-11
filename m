Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874E2D6E4B;
	Wed, 11 Mar 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233900; cv=none; b=lMug3yw3p9BdkYUQrcUuwG5UN4dCz8NkYGWXZ61TtNBQ3tz0L4fXM+JuTOWmHR+O8LRIc7rLrRoruC3nxiFEDwwummwcOBuoNYmACNHWZ152MIEf1dKI49CuXgywW7SXs+Fi09dZBWJ9dmvLcj4Dsl0Zr+fSN9WtpnyyGeFqgoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233900; c=relaxed/simple;
	bh=cFUMNiYM/8nO88GJBL2GHn+HlsCsnhgl8iEmynnza3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjJVRaajQRXDwO12JER0FniylSEtq/1R5tWmXk4di7AKN18Int/gwCaIzF6ezeZFH7i5S/WEAWaRznDqzH6DYK05JePQD1tXfjCLW8TC8UiodH49ZAOHHjJNV/eQLLklNIq+xK/Lhk/QgTApSSFnApg93cY22bs0VgvrNgGgaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCR8lx+c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCR8lx+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D24C19425;
	Wed, 11 Mar 2026 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773233899;
	bh=cFUMNiYM/8nO88GJBL2GHn+HlsCsnhgl8iEmynnza3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCR8lx+cnMfULVPR+ajusk6D9+5PQVAVKlX9uIwzrNUlAN5ICEvkuP1eGSG4pRXL6
	 Clpuh9J37FrX9iCMhdBDhhPCO44r99I+1t0i3++lMylXrWpIPuy0C5ekjo859BkjVn
	 IjNVW/HloDJ4oCN1bMJU5nPf62M+ZmAH6CHHkY7l2yTg6EizdV7RuyOLcgrcJnGsg1
	 hmoaQB5hNIRpveUr5xrHxgQQxjNUMcDqZcVKxrbc/MXonvEsdtnHL0Jbve+DxT4l18
	 dsPj0xHk15B9oXvVC6vgps46dNNemUq5QgG4BDjrir94f5mAeA9QDW8xkteoCpA2OF
	 Ll3cxytqoibNQ==
Date: Wed, 11 Mar 2026 13:58:17 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 2/4] rcu/nocb: Extract nocb_bypass_needs_flush()
 to reduce duplication
Message-ID: <abFm6aYxFLuRoGbn@localhost.localdomain>
References: <20260224230435.3390963-1-joelagnelf@nvidia.com>
 <20260224230435.3390963-3-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224230435.3390963-3-joelagnelf@nvidia.com>

Le Tue, Feb 24, 2026 at 06:04:33PM -0500, Joel Fernandes a écrit :
> The bypass flush decision logic is duplicated in rcu_nocb_try_bypass()
> and nocb_gp_wait() with similar conditions.
> 
> This commit therefore extracts the functionality into a common helper
> function nocb_bypass_needs_flush() improving the code readability.
> 
> A flush_faster parameter is added to controlling the flushing thresholds
> and timeouts. This design was in the original commit d1b222c6be1f
> ("rcu/nocb: Add bypass callback queueing") to avoid having the GP
> kthread aggressively flush the bypass queue.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
