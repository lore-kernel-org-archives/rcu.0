Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714581DFE1;
	Mon,  6 May 2024 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992098; cv=none; b=sVsjV+0gqiqfnHpiSCRrpVeoTxG360S/2YDzcPoJOWGkxioyt0iaiUNCIKdiT0JzIUVPcZJtINtESLeyjL84XwRvekP9Sv+4pTMWXgV32QBzrkrzlMLij/i/hV3CzlhmDlzlad9MnsCRYryuyuVEcXlQAgt6ykswWrp9Aqkly1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992098; c=relaxed/simple;
	bh=RvKNpsE+wsfu1M3mRHzh7rPwiNXrwCj5mB+aHtyY1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANGK6kqJZ1YxK3YUCRXXEyA/BGzLA8gc+PZvfyadoNLiqadd3J52PYGF//E/DjR0gxUZQf6kjN2P3suxuGkTX5Yq/Okdo2mfgyr7vvVJydFR2aHZiLOJSDX0Am8jnKJ/aK05elqi/K4AuGbaUhfvsoCysw1WXuJ8jLqjAq5oaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtFX5LJr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtFX5LJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41CFC116B1;
	Mon,  6 May 2024 10:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992098;
	bh=RvKNpsE+wsfu1M3mRHzh7rPwiNXrwCj5mB+aHtyY1Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AtFX5LJrB6AHxQNjwM0YRwvL6/slRM5Jb6Aj8Jh5dDvjbOm0rB4L2icW2CcpKGyPU
	 87WL4pdlbFPNjpHCI/SXFrCv5GJocGi0Bs6OyMShFS9+7VIb7R6F5WlDO89vhpYg/d
	 kb4MbIgbZzup8VikYZ+HRJffeoEGZSFfSaFtn4TmfzlHhXCnVgBMufnPY6oROKl65s
	 5/TJ07xsmQBMiFuo7k6UTPdL6xA3sQ66vABGnJYUAkV3uvkg9+BRdYDbRUs4hrNrt8
	 5MVUblTPY2UxezObJIk27cQGOrw80Egju/U1VQjy6jaL5vScaijDele8p9FjmPuTPw
	 5RDK1JWICrH0w==
Date: Mon, 6 May 2024 12:41:35 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 03/27] context_tracking, rcu: Rename ct_dynticks()
 into ct_rcu_watching()
Message-ID: <Zjiz39e-XmOExPkM@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-4-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-4-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:07AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
