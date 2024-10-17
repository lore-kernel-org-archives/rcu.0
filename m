Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6121DEFC0;
	Thu, 17 Oct 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179412; cv=none; b=XdrkyIgMbTLC90cL+RNUoZe3NPgxLnFRTX+krWBaLRUTbyOISgR9hPHQGtnjsBshRNkRp7FpTA5Pjrr/Lf4j2972YiXYhhyzrEzcv/02Yl0O37jAxAwUpHQH+lwqNVUpAUGVR1w5PvcfVkwtD3U5FprvabGDow/rXqkP5G9BIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179412; c=relaxed/simple;
	bh=zTizfCUOt/3Bz6qO76pDNEOKzNY2vPvUOvQcSUnWW2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK4qB0MeKcEz1AdurOCoSsBLkX/v32xgPxVPXNNspMTzwL4A5B5sFcpDUUde7mUf/3vadyJC7189eCMgU/aO28s00hMBT8WawhejkCDtVoclATj2eAj0heYhzF4jKXxEn3yc7/VMF7AJIo3P74x9FsMB+jjI+7qad56SErIhB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIHdQzlD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIHdQzlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92203C4CEC3;
	Thu, 17 Oct 2024 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729179412;
	bh=zTizfCUOt/3Bz6qO76pDNEOKzNY2vPvUOvQcSUnWW2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIHdQzlDBEs0uNi3LIaaYV4V4GNjoBgs5wUBwMQ7kQcHRzRUdyLgIjq1vImBO4cEG
	 dWaCBEZ/IgaqmzpF2gWe++jan+vjjkQo+Ew35gUYWO+ek9CdPEvmOd8UH3/n+JLNvS
	 V2mvjzA1AxDKeELWdgeLOi26PhRSXuWNOaKt++cNMarAHNNI54D2o3Cxj5TeQR38t+
	 WVgQSzsndI7nVyTwedxvCorVWyD2+1Aw/c4ivBoqERU9ffyiodonfurhroIsNidYiq
	 DVuS6gd09SRIwFTGywmqf8iXc85sgB90p0Maex0XtxEzJiU8rBxTCeAbzcW6N7SEs7
	 2hxKVb2Negzzg==
Date: Thu, 17 Oct 2024 16:36:48 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: paulmck@kernel.org, netdev@vger.kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org,
	matttbe@kernel.org
Subject: Re: [PATCH rcu] configs/debug: make sure PROVE_RCU_LIST=y takes
 effect
Message-ID: <20241017153648.GU1697@kernel.org>
References: <20241016011144.3058445-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016011144.3058445-1-kuba@kernel.org>

On Tue, Oct 15, 2024 at 06:11:44PM -0700, Jakub Kicinski wrote:
> Commit 0aaa8977acbf ("configs: introduce debug.config for CI-like setup")
> added CONFIG_PROVE_RCU_LIST=y to the common CI config,
> but RCU_EXPERT is not set, and it's a dependency for
> CONFIG_PROVE_RCU_LIST=y. Make sure CIs take advantage
> of CONFIG_PROVE_RCU_LIST=y, recent fixes in networking
> indicate that it does catch bugs.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I exercised this in conjunction with tools/testing/selftests/net/config
and the resulting .config is as described before and after.

Reviewed-by: Simon Horman <horms@kernel.org>
