Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1E3CE0B8;
	Thu, 28 May 2026 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972660; cv=none; b=S70lBnsPxaujrGPyeXSgV5PcY4BwnLQSLw4DOcbNOP8+Ddq2GSFgxK+nqv63eSnY6CCZMFXSIsayfvkhL3bACkYn6K2y1dfpl0XFDHmzphjiqY0JwbsFiCDMY2jg6YfLatPwGWMFWAlh53RFaQG6L3Aiggbj72Y3uauSmqB4Wgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972660; c=relaxed/simple;
	bh=WT0jxcFdGIgZMVI3EEMOeqPhkBCPtltW2WC0TkA8MmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaKEzgV/nJDpmja1fhYXQCnNt+PA6uCc1G1ybgsH9l8Id4O4rrdnHHGKZyLpO7qoD9TnCC3aCt8P/1ujlcxlywwBLvNZmGnNkQAH90RxNNP/L5g8X4Ecy768ElUwSf4Pk+kwJDL2xE/EIZOU2UgkoxKAsmksgs5EiAsOfIaYZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hqv3OBV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqv3OBV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E821F000E9;
	Thu, 28 May 2026 12:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779972659;
	bh=j0XSIYtQGKJfhTGxFII5g0zR2rNC1cfOZ9BaWiVyoqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hqv3OBV1sL0D1TxfHr6zlzBzAQ3ApH1h5+6O0RybhgThOU2MhxjXOAR/LDtagChZO
	 zK0ooII0lmk1Wl8OWLvxVETB2xE1rgKAJzQfPzB19KjaFt1UqJhOKNlAhOA/R9ehZs
	 SVZdVMtzOBx6tpFkOR/YX3e843Sy3GY+qzCkDnfrntEVuqPPcmNtccqm9FBuL+o6Sk
	 gZRvFplqzL3TZA3qXoI7yVat+jN/dfeq+bFqrw4am45ssNampxWQjFEDCPjW8cdYY7
	 k+Uha24aDZLMd8l9UToBIVeuw4D/XKSw1uT6VQ/d9kVB60U1SScpD6NEwvk6dd3qqx
	 gJy6CGOasvt2g==
Date: Thu, 28 May 2026 14:50:56 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC PATCH 03/10] rcu/segcblist: Change gp_seq to struct
 rcu_gp_oldstate gp_seq_full
Message-ID: <ahg6ML5r7BGLXalh@localhost.localdomain>
References: <20260417231203.785172-1-puranjay@kernel.org>
 <20260417231203.785172-4-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417231203.785172-4-puranjay@kernel.org>

Hi,

Le Fri, Apr 17, 2026 at 04:11:51PM -0700, Puranjay Mohan a écrit :
> @@ -496,7 +496,7 @@ static void rcu_segcblist_advance_compact(struct rcu_segcblist *rsclp, int i)
>   * Advance the callbacks in the specified rcu_segcblist structure based
>   * on the current value passed in for the grace-period counter.
>   */
> -void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
> +void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *rgosp)

If the name struct rcu_gp_oldstate makes sense when it refers to grace period
sequence numbers waited upon by a given segment, it becomes confusing when
passed here as the current grace period number to compare against waited upon
snapshots.

So how about struct rcu_gp_seq for everyone instead?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
