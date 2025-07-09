Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18FD295525;
	Wed,  9 Jul 2025 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061045; cv=none; b=X8bY3aBGhcqaRaeBzLeKtNEzaTZZYnxhMVwjkFHd9JxCddIdglKQi3PWGNS4uuldIxHr5r44pQh9tGfY32KLB6qUeUU0l0dEM1VgXe60gyOBCbSG87SU7ZI53XqAMi5AqQ/an9gxdQbI+JyBNmA9/LibVffMSXxnN4x8np8IMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061045; c=relaxed/simple;
	bh=Ncjiq8Ee5pSzyODn6YKaE9dcA+1GZhGeFCTm/glfm1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVNE424RUnF5aHhusFTcimc8TKo8Wrb8w32ZRTiKOWOFJ2HjmfSH1l1qGjRIbazJG7qegPAJEMhHPBvxTAWiPCipp06Y3C2cRXRmexfFtG0snUg3D1hxfftY+M1rL8INxdE0HLyIw/V6r1ioH/4use6GkGsR9t4yO19Gj4lqVto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5ey3fUq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5ey3fUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E1AC4CEEF;
	Wed,  9 Jul 2025 11:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752061044;
	bh=Ncjiq8Ee5pSzyODn6YKaE9dcA+1GZhGeFCTm/glfm1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5ey3fUqn5+TMmIhPtRVsGWaqhrA+LW+gu72rloHw91HHGPA21dqPQzy7EdIlUfg5
	 yje1IQ0jdGNXmzOSLIvvG+Dov286ghIO5hl5gtDJuX9AQUjsH7kyaDDWbPE5B0WRJq
	 5xisThFn7Lmfgp3XGQ0BNr9z1STATXAGZXZlwGYuNSxJHZP3nVSPBAmPVbwmzi06yz
	 JlFFq631wHvubXM1DiUCxqQJh/E6sASLpUwSYK+TI5x1XMWFWGILKXZzBK0oJxwACy
	 tIgT9dLGKHf94AYH2aNBZRexrTIS4mg25i93h3LvcPsP3l9sU6jKWfoeFjnIrnNlX2
	 HkXivPI5MXxnw==
Date: Wed, 9 Jul 2025 13:37:21 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com, neeraj.upadhyay@amd.com
Subject: Re: [PATCH rcu 4/5] Documentation/kernel-parameters: Update
 rcu_normal_wake_from_gp doc
Message-ID: <aG5UcXSbQf2RqZNk@localhost.localdomain>
References: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
 <20250709104118.15532-5-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709104118.15532-5-neeraj.upadhyay@kernel.org>

Le Wed, Jul 09, 2025 at 04:11:17PM +0530, neeraj.upadhyay@kernel.org a écrit :
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> 
> Update the documentation about rcu_normal_wake_from_gp parameter.
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
