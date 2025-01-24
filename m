Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCD41C54B1;
	Fri, 24 Jan 2025 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759842; cv=none; b=uqW4v+AkxCInThmisUGbkE9eNWEAXo61f6x2Oz0/iYd7ssaKYMW/181CN/XHba7orY4yfUKbpfXXx0JFUFjfVW/ymEbQaXDdHa3yCKQBQnE1Q5+aUMeg0+vQDnrDSUu5oGH000qI+/iw6kVVEWoXDX9RvcP+fn/CRHClrq1akL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759842; c=relaxed/simple;
	bh=zPoDq63HwIFTbeNhaTj+1USIJUfLPWWLh8+bXs3B5A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP9EDMhaIQu3SsZNk77Lf37wDz2CzTcmLM+vwL5VYRBBuGRJ9cCn2YEFtNDiJgQIF0QeefXHS/ZSaUvqv1eWeLub6AAcrtNaxPBSb/AjEc4gOLccS+AR9hF1C4a1ABON+MrSgbPL7UWYOUKfyR6welRsSKmy7JL0TUebzRJL7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBCVn87K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBCVn87K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E355C4CED2;
	Fri, 24 Jan 2025 23:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737759841;
	bh=zPoDq63HwIFTbeNhaTj+1USIJUfLPWWLh8+bXs3B5A0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBCVn87Kr58OB4ZPWX8yxOPEpZWKNpBn7f6jsM8kbPAlPD1fsE/eA6N/XUD6jwK53
	 2yAWeG1VDRU+LdhOnSmdqinFsfDh7zkSL4fbn0IqyPPpZVOZWQXXaBisGoR03yauEC
	 2EydU0QBMccmPjPBb5PzQNWrzno0qXrycpamCqJb/GrhF5f0lXqz8IhwojyzvGKaJ5
	 YgFRf8vPwXDDra0CUIyeSkH96Mfuyb07/zaebPUvRAuO7ZZQKkNSN1pR3f8ol8ve2a
	 u4joKH7XqoZaFHzsliqJoe9ZkAhKft3HsqCAAO1DuZQP24oCgi/MQdodyeOxK3dWxF
	 KzLKqsOsDsWDQ==
Date: Sat, 25 Jan 2025 00:03:58 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start
 detection
Message-ID: <Z5QcXoE0lrS6yIBt@pavilion.home>
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
 <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop>

Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. McKenney a écrit :
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 2f9c9272cd486..d2a91f705a4ab 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
>  {
>  	unsigned long cur_s = READ_ONCE(*sp);
>  
> -	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
> +	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));

This might need a comment.

The way I understand it is that rcu_state.gp_seq might be seen started while
root_rnp->gp_seq is not. So rcu_seq_snap() on the started rcu_state.gp_seq
may return maximum 2 full GPs ahead of root_rnp->gp_seq. And therefore it takes below
2 GPs to safely deduce we wrapped around.

Should it be ULONG_CMP_LT(cur_s, s - (2 * (RCU_SEQ_STATE_MASK + 1))) ?

Or am I missing something?

Thanks.
