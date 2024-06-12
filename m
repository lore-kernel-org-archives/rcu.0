Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6B180A65
	for <rcu@vger.kernel.org>; Wed, 12 Jun 2024 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211457; cv=none; b=kP8KzUJ5+WeE4ROnQ5ePAl/pu49vHAjF+csJRHaC/rUlMiv4jvQgBjcH7RCZjnO7Vyul05RHM+/D0gI+n2H9D5crWnTclXq1Rns3kV8x3zJQSY7i9cU6Wnv07GyWR3WG9utdvm8cP11iEE9dha2ZIQ47jnmKCMkePmdj8rxnATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211457; c=relaxed/simple;
	bh=vebMEaW02jolhLdtvQPmHMC1OEEbWYTVGy+Bor5wYMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DL9hFKU6RG5pmCFrccmny0V16dcBmUWU7fVlYIUG4PgQ6BN3B1f6wRZ5XKcrcCXbaBVZ5Jj5TPLA3MEogAZyIonPnm9VrUs5H3hvRbsEZbcAbR3M1yuX5gDUqugp9AgfXBSUxTd9lQGj/Nt1XJa+Frsm3nII6iCZ1K3w8bnlJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d+l1Ih95; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d+l1Ih95"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-250aa23752dso340fac.3
        for <rcu@vger.kernel.org>; Wed, 12 Jun 2024 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718211454; x=1718816254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAftVLKn20HbmalpH3Tni7KQXwsU3yAXAUhGqIphnu0=;
        b=d+l1Ih95QeAlRyz0HNZpXALgmOEuWDHQFwfysCuMSY3ZA40F08jSQrUmTx2gl8Mbi+
         qAETXqgkSFv7duiRBXhNNElzK1VVoCXfv2y/XbbyBeN+a1ELF6YOq1oisGmpkBIKFg0C
         lJs+G9IaBI2Jo3r42Kh5/Q+/2ekT/FTHoR3aMcSN7Ct9U9td6I34ihp3783vBaahWA1a
         xRNBvWtFrMdMiIQXMR1HdrW+t68KdtxtXG7LqNhNB7eEyyv2SnHKIax2Eegwp140t4Z3
         cJqKx4WWpXv2EYYO9vP5miFNt2qW9C3Ff04UoqH73lraY9p+yp4q3CJdltjhgBC0WfKW
         px5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211454; x=1718816254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAftVLKn20HbmalpH3Tni7KQXwsU3yAXAUhGqIphnu0=;
        b=jPRdR77RkS7PmRm/OlEzEgDuNTFoHg5tQdwOIjLCIDXG5gbMxHR+BqmKh/3rmfxClp
         D9mI68nA62oIyxxdpg27TaF6HVJbtXmP7zz00D5MTcSCDBasQILk8tv6kniLyt0EZiwq
         PajsihItJkkj6/zKfbZrTyYzdNkrok3V+KwJlhCXSYdOb7d9KgiR+r+/LxKfIpxs3bwq
         Ev1ZMNhIGQcKvTjSRRvN6FRIxIUYS35gch7u0vQoTo5lI7GAo24GmWWAvesKhNO0cfvr
         F/66u4Fh+hmi4I3KLx9kII+tEM/ObY5sOx7A3weQjmRD7zvPmcqsAutugGZ6bKIjIUmK
         QPHg==
X-Forwarded-Encrypted: i=1; AJvYcCVLbKv2SbDMHdHGjV1vzcSyNvoul+3MOCPdNfxL67R5LsPKDzDxYEEs1181cOU28UJMT6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP1hPU9sOvJXHEqSJiV2NXvrM8mlsp6AZhCiIc30/rITGskI/n
	e/GwmcS1c4h0tTKTQiyAdqoWS8dHHnKeJawOMHqjn3cmv9XvPCJIBaH9RVdmwJU=
X-Google-Smtp-Source: AGHT+IE5gURtOYtjCbJQWtUubvSvxNRA1uBWwaFjKaz5/Y4ebMHZrD+Oj4sfPGkerxg+PybPLlQnIg==
X-Received: by 2002:a05:6870:818f:b0:254:affe:5a08 with SMTP id 586e51a60fabf-25514c7026emr2515800fac.2.1718211454633;
        Wed, 12 Jun 2024 09:57:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-254d96e5e7fsm1377401fac.26.2024.06.12.09.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:57:34 -0700 (PDT)
Message-ID: <ec203c0e-13a9-4163-94dd-a8a8d6d2c070@kernel.dk>
Date: Wed, 12 Jun 2024 10:57:30 -0600
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with
 TIF_SIGPENDING
To: Oleg Nesterov <oleg@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Rachel Menge <rachelmenge@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 Wei Fu <fuweid89@gmail.com>, apais@linux.microsoft.com,
 Sudhanva Huruli <Sudhanva.Huruli@microsoft.com>,
 Christian Brauner <brauner@kernel.org>,
 Mike Christie <michael.christie@oracle.com>,
 Joel Granados <j.granados@samsung.com>, Mateusz Guzik <mjguzik@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
References: <1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com>
 <20240608120616.GB7947@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240608120616.GB7947@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/24 6:06 AM, Oleg Nesterov wrote:
> kernel_wait4() doesn't sleep and returns -EINTR if there is no
> eligible child and signal_pending() is true.
> 
> That is why zap_pid_ns_processes() clears TIF_SIGPENDING but this is not
> enough, it should also clear TIF_NOTIFY_SIGNAL to make signal_pending()
> return false and avoid a busy-wait loop.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

