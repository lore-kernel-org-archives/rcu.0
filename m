Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45F1ABEBB;
	Thu, 15 Aug 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730746; cv=none; b=eZs2AnLP2ex0te5PrY5Bz/NfRhwtRxIaM7JMGEA7NGxTgSzZZ7Wpu6CrkRyFc3mSQz9Hr3tMQmaRd8MkBb76eSRLAI0ra0+Drl1HCJe6i2quV7xTKiCPujgndEz8+8W1NG8R6pA9H1m2qVzVuF+gsHgwY0xs28K1Htq1YCsqneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730746; c=relaxed/simple;
	bh=pRDl808HLnWOnC9EcCFGMLdCrDv0Yvjpp5BDFWwe9Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QI2nUURrNNsKcLVFuqv10Q1rLDb153hRpPWcvdVjoVuLw7s7QBgpEQ36gFhCFbXHofkbomrrkiBS98tnluw8MfHTOjlyjr4h77vVGCujLFNeelH/7q+8CLCWB4O2rcR3L8uVNu9f+mmhukXsRXHS56P4Q5AfEeMuZ7juca3MTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3JabwJ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3JabwJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E85AC4AF0C;
	Thu, 15 Aug 2024 14:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730745;
	bh=pRDl808HLnWOnC9EcCFGMLdCrDv0Yvjpp5BDFWwe9Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3JabwJ/rKlIBX6Jr5MDfjFQaBQkxiTbwLadbtjkckwrepFzgIXwAk7+ACRh1aPv5
	 zHqtSQ8Zg501MP+Pyq4n1zz6L8V93a+xLoanSEym9AxDk6mo3dUYhFA+4kT9aWMbfg
	 eelNiNaKBIk4JOsbvoCf4M6iv517VOix9PPw13fHIbZHRK/pw7bxVmNQcqqHwCg3Tz
	 5v4lRnS5i9s/SPc61jqO5Fx3rIDjA0T8Sx7fzpV1ZL764ovCCTPJcGdMdiHh7NG3uT
	 vi0SPypZpkiM6DZTmVbz0wd11zJxyjYNvhm4a8Ul3IuKe2qU5uTYd44MIptxNHnpRc
	 36oBJdn5gIxow==
Date: Thu, 15 Aug 2024 16:05:43 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] rcu: Remove unused declaration
 rcu_segcblist_offload()
Message-ID: <Zr4LN_77vKUCiJV0@pavilion.home>
References: <20240815085053.4157590-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815085053.4157590-1-yuehaibing@huawei.com>

Le Thu, Aug 15, 2024 at 04:50:53PM +0800, Yue Haibing a écrit :
> Commit 17351eb59abd ("rcu/nocb: Simplify (de-)offloading state machine")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
