Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FF215AAB1;
	Mon,  6 May 2024 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715026202; cv=none; b=m2kSIOaGFNDU1xzP4vBx/bEZfWZ3urqb0IS5GIP6psd/qaV/badlhst6/im/86KXWeyJT0wx+eFLnnIUOi6BzduAZyqoSyLE5h1kVSZSzfyHYavcX67qpfIofEjRSHRZTbB3rNfabhSZlglgRIS1PB+Aow8DV9ZY5Foxr8alqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715026202; c=relaxed/simple;
	bh=jlqVI/LUVHrNc8apztU92wxCO2bwDs1ydUhERRNugQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TagDEHX3OA+yOJTPIwP5TrzF3hrAeXkUXqV22Qvd04Bcu2CyXdB5D8T5OAUhDxoiYWH7HWyB4w70rfEpmJj6F5ZMNkoqJJZPDOyOHVh6bZoHKQ4BlsNj+LoIzEOeOPyCWp37HS+Pr24ypJ0mfOF5pCVuRGkgGuW6mSkzZZGDq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyAiVKs5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyAiVKs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46750C116B1;
	Mon,  6 May 2024 20:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715026201;
	bh=jlqVI/LUVHrNc8apztU92wxCO2bwDs1ydUhERRNugQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyAiVKs5H48xgjOfiPGBe/WtOmUGWVsjrt3mCcx9ac999uy0SaXWPDnXEdQI3Zzgj
	 Hk54BkzdKDe4qhINFNTdynAfM4u79UnSEUnJILMLtdDK7usJQMUpWu5P6ZshxnyZxr
	 P4XZLdJnTqfGz9z+VIsd/cxRcOLI/KGunp+YEGVz9CdM5n3pX3cJ7FXoAKD7GaJWAQ
	 98PROqm93wEHlT5PlVIsP/ohbX2fdH+ZoZ7InR8gsqFbEuq/xBhxjV8ARAehbPp5oA
	 E19mmj9560MlH3woxqLvNvW+necY5YWJ1+IoLzLSHNnVYdUxCRljRO8hszcJwZKlD7
	 W9xnOQnka9AUg==
Date: Mon, 6 May 2024 22:09:58 +0200
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
Subject: Re: [PATCH v2 08/27] context_tracking, rcu: Rename
 ct_dynticks_nesting_cpu() into ct_nesting_cpu()
Message-ID: <Zjk5Fn0CwoZxc8Ef@pavilion.home>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-9-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-9-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:12AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
> meaning.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
